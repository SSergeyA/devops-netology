# Sergey Sokolov

## Домашнее задание к занятию "14.4 Сервис-аккаунты"
### Задача 1: Работа с сервис-аккаунтами через утилиту kubectl в установленном minikube

Выполните приведённые команды в консоли. Получите вывод команд. Сохраните задачу 1 как справочный материал.
Как создать сервис-аккаунт?

kubectl create serviceaccount netology

Как просмотреть список сервис-акаунтов?

kubectl get serviceaccounts
kubectl get serviceaccount

Как получить информацию в формате YAML и/или JSON?

kubectl get serviceaccount netology -o yaml
kubectl get serviceaccount default -o json  
![image](https://user-images.githubusercontent.com/93119897/211821485-3accea6d-9477-4d02-9abb-c73a4c880d79.png)

Как выгрузить сервис-акаунты и сохранить его в файл?

kubectl get serviceaccounts -o json > serviceaccounts.json
kubectl get serviceaccount netology -o yaml > netology.yml

Как удалить сервис-акаунт?

kubectl delete serviceaccount netology

Как загрузить сервис-акаунт из файла?

kubectl apply -f netology.yml  

![image](https://user-images.githubusercontent.com/93119897/211821615-634d3971-948d-47cf-9fc3-b7020dba8632.png)


### Задача 2 (*): Работа с сервис-акаунтами внутри модуля

Выбрать любимый образ контейнера, подключить сервис-акаунты и проверить доступность API Kubernetes

kubectl run -i --tty fedora --image=fedora --restart=Never -- sh

Просмотреть переменные среды

env | grep KUBE

![image](https://user-images.githubusercontent.com/93119897/211822670-e59f085c-e20d-463b-9ab2-fa6b11438a5f.png)

Получить значения переменных

K8S=https://$KUBERNETES_SERVICE_HOST:$KUBERNETES_SERVICE_PORT
SADIR=/var/run/secrets/kubernetes.io/serviceaccount
TOKEN=$(cat $SADIR/token)
CACERT=$SADIR/ca.crt
NAMESPACE=$(cat $SADIR/namespace)  
![image](https://user-images.githubusercontent.com/93119897/211822720-ac7d32df-46b4-4dc4-8fc8-80a33909a768.png)

Подключаемся к API

curl -H "Authorization: Bearer $TOKEN" --cacert $CACERT $K8S/api/v1/  

![image](https://user-images.githubusercontent.com/93119897/211822802-b1d096ba-de00-4f0f-8114-58c872bef10b.png)

В случае с minikube может быть другой адрес и порт, который можно взять здесь

cat ~/.kube/config

или здесь

kubectl cluster-info
