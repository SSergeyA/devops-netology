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
  zone      = "ru-central1-a"
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
# маршрут из  приватной сети наружу через нат шлюз
resource "yandex_vpc_route_table" "route-1" {
  name       = "interne-route"
  network_id = yandex_vpc_network.network-1.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = yandex_compute_instance.n-1.network_interface.0.ip_address
  }
}
# приватную
resource "yandex_vpc_subnet" "subnet-2" {
  name           = "private"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.20.0/24"]
  route_table_id = yandex_vpc_route_table.route-1.id
}
# NAT
resource "yandex_compute_instance" "n-1" {
  name = "n1"

 resources {
    cores  = 2
    memory = 2
  }
  boot_disk {
    initialize_params {
      image_id    = "fd80mrhj8fl2oe87o4e1" 
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    ip_address = "192.168.10.254"
    nat       = true
  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
# VM1 public
#resource "yandex_compute_instance" "vm1" {
 # name     = "VM1public"
resource "yandex_compute_instance" "vm-1" {
  name = "public1"
  resources {
    cores  = 2
    memory = 2
  }
  boot_disk {
    initialize_params {
      image_id    = "fd8fte6bebi857ortlja"
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
# VM1 public
resource "yandex_compute_instance" "vm2" {
  name     = "vmprivate"
  resources {
    cores  = 2
    memory = 2
  }                    
  boot_disk {
    initialize_params {
      image_id    = "fd8fte6bebi857ortlja"
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-2.id
    nat       = false
  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
# ip
output "internal_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.ip_address
}
output "external_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
}
output "internal_ip_address_vm_2" {
  value = yandex_compute_instance.vm2.network_interface.0.ip_address
}
output "external_ip_address_vm_2" {
  value = yandex_compute_instance.vm2.network_interface.0.nat_ip_address
}
output "internal_ip_address_NAT" {
  value = yandex_compute_instance.n-1.network_interface.0.ip_address
}
output "external_ip_address_NAT" {
  value = yandex_compute_instance.n-1.network_interface.0.nat_ip_address
}


