# задаю конфигурацию провайдера
terraform {
  required_version = ">= 1.1.0"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.13"
    }
  }
}
provider "yandex" {
  token     = var.YC_TOKEN
  cloud_id  = var.YC_CLOUD_ID
  folder_id = var.YC_FOLDER_ID
  zone      = "ru-central1-a"
}
# создаю сеть
resource "yandex_vpc_network" "network-1" {
  name = "network_ser"
}
# создаю private подсеть в 3 зонах
resource "yandex_vpc_subnet" "subnet-1a" {
  name           = "private-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}
resource "yandex_vpc_subnet" "subnet-1b" {
  name           = "private-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.110.0/24"]
}
resource "yandex_vpc_subnet" "subnet-1c" {
  name           = "private-c"
  zone           = "ru-central1-c"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.210.0/24"]
}

# SQL cluster

resource "yandex_mdb_mysql_cluster" "mysql-1" {
  name                = "MySQL-s"
  environment         = "PRESTABLE"
  network_id          = yandex_vpc_network.network-1.id
  version             = "8.0"
  deletion_protection = true

// https://cloud.yandex.ru/docs/managed-mysql/concepts/instance-types
  resources {
    resource_preset_id = "b1.medium" 
    disk_type_id       = "network-hdd" // пока скорость нам не нужна
    disk_size          = "20"
  }
  host {
    zone      = "ru-central1-a"
    subnet_id = yandex_vpc_subnet.subnet-1a.id
  }
  host {
    zone      = "ru-central1-b"
    subnet_id = yandex_vpc_subnet.subnet-1b.id
  }
  host {
    zone      = "ru-central1-c"
    subnet_id = yandex_vpc_subnet.subnet-1c.id
  }
 //  время технического обслуживания
  maintenance_window {
    type = "ANYTIME"
    //day  = <день недели для типа WEEKLY>
    //hour = <час дня для типа WEEKLY>
  }
// время начала резервного копирования
   backup_window_start {
    hours   = 23
    minutes = 59
  }
}

resource "yandex_mdb_mysql_database" "netology_db" {
  cluster_id = yandex_mdb_mysql_cluster.mysql-1.id
  name       = "netology_db"
}

resource "yandex_mdb_mysql_user" "db-user" {
  cluster_id = yandex_mdb_mysql_cluster.mysql-1.id
  name       = "admsergey"
  password   = var.adminpass
  permission {
    database_name = yandex_mdb_mysql_database.netology_db.name
    roles         = ["ALL"]
  }
}



# 2 создаем публичные подсети
resource "yandex_vpc_subnet" "subnet-2a" {
  name           = "public-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.20.0/24"]
}
resource "yandex_vpc_subnet" "subnet-2b" {
  name           = "public-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.120.0/24"]
}
resource "yandex_vpc_subnet" "subnet-2c" {
  name           = "public-c"
  zone           = "ru-central1-c"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.220.0/24"]
}
// k8s cluster
locals {
  k8s_version = "1.22"
  sa_name     = "myaccount"
}


resource "yandex_kubernetes_cluster" "k8s-regional" {
  network_id = yandex_vpc_network.network-1.id
  network_policy_provider = "CALICO"
  master {
    version = local.k8s_version
    public_ip = true
    regional {
      region = "ru-central1"
      location {
        zone      = yandex_vpc_subnet.subnet-2a.zone
        subnet_id = yandex_vpc_subnet.subnet-2a.id
      }
      location {
        zone      = yandex_vpc_subnet.subnet-2b.zone
        subnet_id = yandex_vpc_subnet.subnet-2b.id
      }
      location {
        zone      = yandex_vpc_subnet.subnet-2c.zone
        subnet_id = yandex_vpc_subnet.subnet-2c.id
      }
    }
    //security_group_ids = [yandex_vpc_security_group.k8s-main-sg.id]
  }
  service_account_id      = yandex_iam_service_account.myaccount.id
  node_service_account_id = yandex_iam_service_account.myaccount.id
  depends_on = [
    yandex_resourcemanager_folder_iam_binding.k8s-clusters-agent,
    yandex_resourcemanager_folder_iam_binding.vpc-public-admin,
    yandex_resourcemanager_folder_iam_binding.images-puller
  ]
  kms_provider {
    key_id = yandex_kms_symmetric_key.kms-key.id
  }
}


resource "yandex_iam_service_account" "myaccount" {
  name        = local.sa_name
  description = "K8S regional service account"
}

resource "yandex_resourcemanager_folder_iam_binding" "k8s-clusters-agent" {
  # Сервисному аккаунту назначается роль "k8s.clusters.agent".
  folder_id = var.YC_FOLDER_ID
  role      = "k8s.clusters.agent"
  members = [
    "serviceAccount:${yandex_iam_service_account.myaccount.id}"
  ]
}
# Назначение роли сервисному создания балансера
resource "yandex_resourcemanager_folder_iam_member" "sa-lb" {
  folder_id = var.YC_FOLDER_ID
  role      = "load-balancer.admin"
  member    = "serviceAccount:${yandex_iam_service_account.myaccount.id}"
}

resource "yandex_resourcemanager_folder_iam_binding" "vpc-public-admin" {
  # Сервисному аккаунту назначается роль "vpc.publicAdmin".
  folder_id = var.YC_FOLDER_ID
  role      = "vpc.publicAdmin"
  members = [
    "serviceAccount:${yandex_iam_service_account.myaccount.id}"
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "images-puller" {
  # Сервисному аккаунту назначается роль "container-registry.images.puller".
  folder_id = var.YC_FOLDER_ID
  role      = "container-registry.images.puller"
  members = [
    "serviceAccount:${yandex_iam_service_account.myaccount.id}"
  ]
}

resource "yandex_kms_symmetric_key" "kms-key" {
  # Ключ для шифрования важной информации, такой как пароли, OAuth-токены и SSH-ключи.
  name              = "kms-key"
  default_algorithm = "AES_128"
  rotation_period   = "8760h" # 1 год.
}

resource "yandex_kms_symmetric_key_iam_binding" "viewer" {
  symmetric_key_id = yandex_kms_symmetric_key.kms-key.id
  role             = "viewer"
  members = [
    "serviceAccount:${yandex_iam_service_account.myaccount.id}",
  ]
}
// создание группы узлов для кластера

resource "yandex_kubernetes_node_group" "php-ngroup" {
  cluster_id = yandex_kubernetes_cluster.k8s-regional.id
  name       = "phpgroup"
  version = local.k8s_version
  instance_template {
    platform_id = "standard-v2"
    metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
    network_interface {
      nat                = true
      subnet_ids         = ["${yandex_vpc_subnet.subnet-2a.id}"]
    }

    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      type = "network-hdd"
      size = 35
    }

    scheduling_policy {
      preemptible = false
    }

    container_runtime {
      type = "containerd"
    }
  }
  scale_policy {
    auto_scale {
      min = 3
      max = 6
      initial = 3
    }
  }

  allocation_policy {
    location {
        zone      = yandex_vpc_subnet.subnet-2a.zone
      }
  }

}

output mysqlclusterhost{
  value = { for v in yandex_mdb_mysql_cluster.mysql-1.host: v.zone => v.fqdn }
}


output "internal_ip_k8s" {
  value = yandex_kubernetes_cluster.k8s-regional.master.0.external_v4_endpoint
}

output "cluster_id" {
  value = yandex_kubernetes_cluster.k8s-regional.id
}

