# Sergey Sokolov
## Домашнее задание к занятию "14.2 Синхронизация секретов с внешними сервисами. Vault"
### Задача 1: Работа с модулем Vault

Запустить модуль Vault конфигураций через утилиту kubectl в установленном minikube

kubectl apply -f 14.2/vault-pod.yml

Получить значение внутреннего IP пода

kubectl get pod 14.2-netology-vault -o json | jq -c '.status.podIPs'  
![image](https://user-images.githubusercontent.com/93119897/209360124-77870040-4637-4686-8a2e-a4ab953e2529.png)


Примечание: jq - утилита для работы с JSON в командной строке

Запустить второй модуль для использования в качестве клиента

kubectl run -i --tty fedora --image=fedora --restart=Never -- sh

Установить дополнительные пакеты

dnf -y install pip
pip install hvac  

![image](https://user-images.githubusercontent.com/93119897/209360184-c4b60e42-7b83-4ef6-a276-ca2712f53e40.png)

Запустить интепретатор Python и выполнить следующий код, предварительно поменяв IP и токен
```
import hvac
client = hvac.Client(
    url='http://10.10.133.71:8200',
    token='aiphohTaa0eeHei'
)
client.is_authenticated()

# Пишем секрет
client.secrets.kv.v2.create_or_update_secret(
    path='hvac',
    secret=dict(netology='Big secret!!!'),
)

# Читаем секрет
client.secrets.kv.v2.read_secret_version(
    path='hvac',
)  
```
![image](https://user-images.githubusercontent.com/93119897/209360250-fe913fed-5a2f-4fa1-b74c-0167bff67569.png)
![image](https://user-images.githubusercontent.com/93119897/209360278-f7ab3796-369e-4ad0-a9ef-7012e86a312a.png)

