
provider "yandex" {
  token = "AQAAAABgkUTRAATuwde2SJW_zkgGso4ZqCtAZkc"
  cloud_id  = "b1gd88frf016p6u7jbkb$"
  folder_id = "b1gump4iofj1llimbreg"
  zone      = "ru-central1-a"
}

module "vm-1" {
  source = "../terraform15/modules/"
  count = local.vm-count[terraform.workspace]
  name = "vm-${terraform.workspace}-${count.index+1}"
  platform_id = local.platform[terraform.workspace]
  users         = "sergey"
  cores  = local.vm-cores[terraform.workspace]
  memory = local.vm-memory[terraform.workspace]
  image = "centos-8"
  subnet_id = yandex_vpc_subnet.subnet-1.id
  nat       = true
  
  
} 


module "vm-2" {
  source = "../terraform15/modules/"
  for_each = local.virtual_machines[terraform.workspace]
  name     = "vm-${terraform.workspace}-${each.key}"
  users         = "sergey"
  cores  = each.value.cores
  memory = each.value.memory
  image = "centos-8"
  subnet_id = yandex_vpc_subnet.subnet-1.id
  nat       = true
  
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



