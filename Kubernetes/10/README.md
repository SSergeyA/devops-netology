# Sergey Sokolov
## Домашнее задание к занятию "13.1 контейнеры, поды, deployment, statefulset, services, endpoints"

Настроив кластер, подготовьте приложение к запуску в нём. Приложение стандартное: бекенд, фронтенд, база данных. Его можно найти в папке 13-kubernetes-config.
### Задание 1: подготовить тестовый конфиг для запуска приложения

Для начала следует подготовить запуск приложения в stage окружении с простыми настройками. Требования:

    под содержит в себе 2 контейнера — фронтенд, бекенд;
    регулируется с помощью deployment фронтенд и бекенд;
    база данных — через statefulset.  
    
   [Конфиг stage](https://github.com/SSergeyA/devops-netology/blob/main/Kubernetes/10/stage.yaml)  
   [Образ frontend](https://hub.docker.com/layers/ssergeya/frontend/1.0.1/images/sha256-ed23e821b886cc9c82be72bdb8791fe7c612c31c44d15a69715beca3e0e838ff?context=explore)   
   [Образ backend](https://hub.docker.com/layers/ssergeya/backend/2.0.2/images/sha256-e5ccb152a7b35e0ef1d06ba2e12aab9ee8ca3cc9bf62b68aac15b32014adea01?context=explore)  
![image](https://user-images.githubusercontent.com/93119897/203934841-a00005c5-ae8a-41af-a628-233d83aa3cab.png)
![image](https://user-images.githubusercontent.com/93119897/203935015-32ec40ae-b9ea-499f-b4a0-d36100e13849.png)
![image](https://user-images.githubusercontent.com/93119897/203935041-0a04656b-7fcc-4239-bf22-7e02a687b4af.png)

### Задание 2: подготовить конфиг для production окружения

Следующим шагом будет запуск приложения в production окружении. Требования сложнее:

    каждый компонент (база, бекенд, фронтенд) запускаются в своем поде, регулируются отдельными deployment’ами;
    для связи используются service (у каждого компонента свой);
    в окружении фронта прописан адрес сервиса бекенда;
    в окружении бекенда прописан адрес сервиса базы данных.  
 [Конфиг prod](https://github.com/SSergeyA/devops-netology/blob/main/Kubernetes/10/prod.yaml)
![image](https://user-images.githubusercontent.com/93119897/203935078-50630a33-f33a-4e5f-9c64-c9cc9f540cfd.png)
