# Sergey Sokolov
## Домашнее задание к занятию "12.1 Компоненты Kubernetes"

Вы DevOps инженер в крупной компании с большим парком сервисов. Ваша задача — разворачивать эти продукты в корпоративном кластере.
### Задача 1: Установить Minikube

Для экспериментов и валидации ваших решений вам нужно подготовить тестовую среду для работы с Kubernetes. Оптимальное решение — развернуть на рабочей машине Minikube.
Как поставить на AWS:

    создать EC2 виртуальную машину (Ubuntu Server 20.04 LTS (HVM), SSD Volume Type) с типом t3.small. Для работы потребуется настроить Security Group для доступа по ssh. Не забудьте указать keypair, он потребуется для подключения.
    подключитесь к серверу по ssh (ssh ubuntu@<ipv4_public_ip> -i .pem)
    установите миникуб и докер следующими командами:
        curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
        chmod +x ./kubectl
        sudo mv ./kubectl /usr/local/bin/kubectl
        sudo apt-get update && sudo apt-get install docker.io conntrack -y
        curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
    проверить версию можно командой minikube version
    переключаемся на root и запускаем миникуб: minikube start --vm-driver=none
    после запуска стоит проверить статус: minikube status
    запущенные служебные компоненты можно увидеть командой: kubectl get pods --namespace=kube-system
![image](https://user-images.githubusercontent.com/93119897/202020801-9a9022b9-6437-4623-8ab1-d3289ac0879c.png)

Для сброса кластера стоит удалить кластер и создать заново:

    minikube delete
    minikube start --vm-driver=none

Возможно, для повторного запуска потребуется выполнить команду: sudo sysctl fs.protected_regular=0

Инструкция по установке Minikube - ссылка

Важно: t3.small не входит во free tier, следите за бюджетом аккаунта и удаляйте виртуалку.

### Задача 2: Запуск Hello World

После установки Minikube требуется его проверить. Для этого подойдет стандартное приложение hello world. А для доступа к нему потребуется ingress.

    развернуть через Minikube тестовое приложение по туториалу
    установить аддоны ingress и dashboard
![image](https://user-images.githubusercontent.com/93119897/202021308-7ff803c7-e4b1-4e46-8289-2324424ccac9.png)
![image](https://user-images.githubusercontent.com/93119897/202021397-113eebfb-3e70-4c4d-a40c-e1d2b0b49661.png)
![image](https://user-images.githubusercontent.com/93119897/202021419-e2f99c75-663b-46c5-ad66-e73785614dfd.png)
![image](https://user-images.githubusercontent.com/93119897/202021480-2deb3a23-7f9b-4734-9cd9-410eaab19ffe.png)

### Задача 3: Установить kubectl

Подготовить рабочую машину для управления корпоративным кластером. Установить клиентское приложение kubectl.

    подключиться к minikube
    проверить работу приложения из задания 2, запустив port-forward до кластера  
Тут столкнулся с тем, что скопировав с сервера  ~/.kube/config и сертификаты , в них не было внешнего ip. Остановил minikube
и запустил заново ` minikube start --vm-driver=none  --apiserver-ips=51.250.24.246 ` и опять скопировал сертификаты. 
Потом потребовалось установить ` apt-get -y install socat` ,без него портфорвардинг вылетал.
![image](https://user-images.githubusercontent.com/93119897/202022483-0918dc1f-7177-4f30-a06e-0ad89d6076c8.png)
