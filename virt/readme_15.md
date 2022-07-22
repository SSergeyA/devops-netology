### Sergey Sokolov

## Задание 1

Все получилось сделать, но есть 2 вопроса: </br>
1 - как правильно передавать токен от яндекс облака , ведь его же нельзя оставлять на гитхабе в файле main.tf  общем доступе?</br>
2- как передать ssh ключи в инстанс, т.к. когда выполняется terraform apply они берутся с локальной машины 
```
metadata = {
    ssh-keys = "ubuntu:${file("/home/sergey/.ssh/id_rsa")}"
  }
```

![image](https://user-images.githubusercontent.com/93119897/180446429-06d52fdf-ffa5-48b6-875a-e3d6d747888a.png)
![image](https://user-images.githubusercontent.com/93119897/180446486-c7e9658b-4cdd-4887-96ea-bcde00714fbb.png)
![image](https://user-images.githubusercontent.com/93119897/180446551-27b69b7c-28e5-4117-8046-21b38c6b48b6.png)
![image](https://user-images.githubusercontent.com/93119897/180446630-eaa142f7-c3a7-4b3c-a42e-2e9598be21da.png)
![image](https://user-images.githubusercontent.com/93119897/180446698-2da71390-ee52-4e98-b70a-e5128e973b15.png)


##Задание 2

[server.yaml](https://github.com/SSergeyA/devops-netology/blob/main/virt/15/server.yaml])</br>
[atlantis.yaml](https://github.com/SSergeyA/devops-netology/blob/main/virt/15/atlantis.yaml)

## Задание 3
https://github.com/SSergeyA/devops-netology/tree/main/virt/15/3/terraform15
![image](https://user-images.githubusercontent.com/93119897/180448191-3535dc7e-c9ee-4e81-a752-ec67efb8ed6a.png)
![image](https://user-images.githubusercontent.com/93119897/180448233-54182f40-3c82-4422-aa7e-dfeeb752209c.png)

Модуль instance
```
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
```
