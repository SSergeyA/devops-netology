# Sergey Sokolov  
## Домашнее задание к занятию "14.3 Карты конфигураций"
### Задача 1: Работа с картами конфигураций через утилиту kubectl в установленном minikube

Выполните приведённые команды в консоли. Получите вывод команд. Сохраните задачу 1 как справочный материал.
Как создать карту конфигураций?

kubectl create configmap nginx-config --from-file=nginx.conf
kubectl create configmap domain --from-literal=name=netology.ru

Как просмотреть список карт конфигураций?

kubectl get configmaps
kubectl get configmap

Как просмотреть карту конфигурации?

kubectl get configmap nginx-config
kubectl describe configmap domain

Как получить информацию в формате YAML и/или JSON?

kubectl get configmap nginx-config -o yaml
kubectl get configmap domain -o json

Как выгрузить карту конфигурации и сохранить его в файл?

kubectl get configmaps -o json > configmaps.json
kubectl get configmap nginx-config -o yaml > nginx-config.yml

Как удалить карту конфигурации?

kubectl delete configmap nginx-config

Как загрузить карту конфигурации из файла?

kubectl apply -f nginx-config.yml  
![image](https://user-images.githubusercontent.com/93119897/209850244-ef49d31d-6c3f-4338-9707-10b5eb86db12.png)
![image](https://user-images.githubusercontent.com/93119897/209850292-df17f79c-4269-42b6-adf8-0556c0abfeeb.png)
![image](https://user-images.githubusercontent.com/93119897/209850333-19f3bde7-01f2-41d2-8cf6-59156e5dad47.png)



### Задача 2 (*): Работа с картами конфигураций внутри модуля

Выбрать любимый образ контейнера, подключить карты конфигураций и проверить их доступность как в виде переменных окружения, так и в виде примонтированного тома  
[образ](https://github.com/SSergeyA/devops-netology/blob/main/Kubernetes/17/multiool.yml)   
[configmap](https://github.com/SSergeyA/devops-netology/blob/main/Kubernetes/17/configm2.yml)  (Конфиг взял для примера из официальной доки по  kubernetes, чтоб посмотреть как отображаются различные записи переменных)  
![image](https://user-images.githubusercontent.com/93119897/209850508-180d9a23-5844-44ef-86b7-ec0abb6eea74.png)

