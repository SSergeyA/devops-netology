variable image { default =  "centos-8" }
variable name { default = ""}
variable cores { default = ""}
variable platform_id { default = "standard-v1"}
variable users { default = "centos"}
variable memory { default = ""}
variable subnet_id { default = ""}
variable nat { default = "false"}
variable instance_count { default = 1 }
variable boot_disk { default =  "network-hdd" }
variable zone { default =  "" }
variable folder_id { default =  "" }

terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.61.0"
    }
  }
}

data "yandex_compute_image" "image" {
  family = var.image
}

resource "yandex_compute_instance" "instance" {
  count = var.instance_count
  name = "${var.name}"
  platform_id = var.platform_id
  hostname = "${var.name}}"
  zone = var.zone
  folder_id = var.folder_id

  resources {
    cores  = var.cores
    memory = var.memory
    
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.image.id
      type = var.boot_disk
     }
  }
  network_interface {
    subnet_id = var.subnet_id
    nat       = var.nat
  }

  metadata = {
    ssh-keys = "${var.users}:${file("~/.ssh/id_rsa.pub")}"
  }
}

