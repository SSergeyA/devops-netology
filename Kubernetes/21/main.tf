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
resource "yandex_iam_service_account" "sa" {
  name = "bucketserviceac"
}
# Назначение роли сервисному аккаунту
resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = var.YC_FOLDER_ID
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

# Создание статического ключа доступа
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}

#Создание бакета с использованием ключа
resource "yandex_storage_bucket" "bucket1" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = "sergey-16022023"
}
#получения значений аргументов access_key и secret_key и сохранения данных значений в файле состояния.
output "access_key" {
  value = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  
}
output "secret_key" {
  value = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  sensitive = true
}

resource "yandex_storage_object" "object1" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = yandex_storage_bucket.bucket1.bucket
  key        = "pic.jpg"
  source     = "oslo.jpg"
  acl        = "public-read"
}
output "url" {
  value = "https://storage.yandexcloud.net/${yandex_storage_bucket.bucket1.bucket}/${yandex_storage_object.object1.key}"
}

# создаю сеть
resource "yandex_vpc_network" "network-1" {
  name = "network_ser"
}
# создаю публичную подсеть
 resource "yandex_vpc_subnet" "subnet-1" {
   name           = "public"
   zone           = "ru-central1-a"
   network_id     = yandex_vpc_network.network-1.id
   v4_cidr_blocks = ["192.168.10.0/24"]
}

# создание сервисного аккаунта и  инстанс группы
resource "yandex_iam_service_account" "ig-sa" {
  name        = "ig-sa"
  description = "service account to manage IG"
}

resource "yandex_resourcemanager_folder_iam_binding" "editor" {
  folder_id = var.YC_FOLDER_ID
  role      = "editor"
  members   = [
    "serviceAccount:${yandex_iam_service_account.ig-sa.id}",
  ]
  depends_on = [
    yandex_iam_service_account.ig-sa,
  ]
}

resource "yandex_compute_instance_group" "ig-1" {
  name               = "lamp-ig"
  folder_id          = var.YC_FOLDER_ID
  service_account_id = "${yandex_iam_service_account.ig-sa.id}"
  depends_on          = [yandex_resourcemanager_folder_iam_binding.editor]
  instance_template {
    platform_id = "standard-v1"
    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = var.lamp_id
      }
    }

    network_interface {
      network_id = "${yandex_vpc_network.network-1.id}"
      subnet_ids = ["${yandex_vpc_subnet.subnet-1.id}"]
    }

    metadata = {
      ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
      user-data = <<EOF
#!/bin/bash
yum install httpd -y
service httpd start
chkconfig httpd on
cd /var/www/html
echo '<html><img src="https://storage.yandexcloud.net/${yandex_storage_bucket.bucket1.bucket}/${yandex_storage_object.object1.key}"/></html>' > index.html
      EOF
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = ["ru-central1-a"]
  }

  deploy_policy {
    max_unavailable = 2
    max_expansion = 0
  }
  load_balancer {
    target_group_name        = "target-group1"
    target_group_description = "load balancer target group"
  }

}

# балансировщик
resource "yandex_lb_network_load_balancer" "balans" {
  name = "my-network-load-balancer"

  listener {
    name = "my-listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_compute_instance_group.ig-1.load_balancer[0].target_group_id

    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}
output "balance_target_group_id" {
  value = yandex_compute_instance_group.ig-1.load_balancer[0].target_group_id
  }

#получения ip балансировщика.
output "balancer_ip" {
  value = yandex_lb_network_load_balancer.balans.listener.*.external_address_spec[0].*.address
  }







