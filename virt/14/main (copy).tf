
provider "yandex" {
  cloud_id  = "b1gd88frf016p6u7jbkb$"
  folder_id = "b1gump4iofj1llimbreg"
  zone      = "ru-central1-a"
}


resource "yandex_compute_instance" "vm-1" {
  count = local.vm-count[terraform.workspace]
  name = "vm-${terraform.workspace}-${count.index+1}"
  platform_id = local.platform[terraform.workspace]

  resources {
    cores  = local.vm-cores[terraform.workspace]
    memory = local.vm-memory[terraform.workspace]
  }

  boot_disk {
    initialize_params {
      image_id = "fd8fte6bebi857ortlja"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("/home/sergey/.ssh/id_rsa")}"
  }
}

resource "yandex_compute_instance" "vm-2" {
  for_each = local.virtual_machines[terraform.workspace]
  name     = "vm-${terraform.workspace}-${each.key}"

  resources {
    cores  = each.value.cores
    memory = each.value.memory
  }

  boot_disk {
    initialize_params {
      image_id = "fd8fte6bebi857ortlja"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("/home/sergey/.ssh/id_rsa")}"
  }
}

locals {
  platform = {
    stage = "standard-v1"
    prod  = "standard-v2"
  }
  
  vm-cores = {
    stage = 2
    prod  = 4
  }

  vm-count = {
    stage = 1
    prod  = 2
  }

  vm-memory = {
    stage = 2
    prod  = 4
  }

  virtual_machines = {
    stage = {
      "2" = { cores = "2", memory = "2" }
    }
    prod = {
      "3" = { cores = "4", memory = "4" },
      "4" = { cores = "4", memory = "4" }
    }
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}




output "internal_ip_address_vm_1" {
  value = { 
 for node in yandex_compute_instance.vm-1:
     node.hostname => node.network_interface.0.ip_address
     }
}


output "external_ip_address_vm_1" {
  value = {
 for node in yandex_compute_instance.vm-1:
     node.hostname => node.network_interface.0.nat_ip_address
     }
}

output "internal_ip_address_vm_2" {
  value = {
 for node in yandex_compute_instance.vm-2:
     node.hostname => node.network_interface.0.ip_address
     }
}


output "external_ip_address_vm_2" {
  value = {
 for node in yandex_compute_instance.vm-2:
     node.hostname => node.network_interface.0.nat_ip_address
     }
}
