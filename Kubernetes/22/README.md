# Sergey Sokolov
## Домашнее задание к занятию 15.3 "Безопасность в облачных провайдерах"

Используя конфигурации, выполненные в рамках предыдущих домашних заданиях, нужно добавить возможность шифрования бакета.
### Задание 1. Яндекс.Облако (обязательное к выполнению)

    С помощью ключа в KMS необходимо зашифровать содержимое бакета:

    Создать ключ в KMS,
    С помощью ключа зашифровать содержимое бакета, созданного ранее.

    (Выполняется НЕ в terraform) *Создать статический сайт в Object Storage c собственным публичным адресом и сделать доступным по HTTPS

    Создать сертификат,
    Создать статическую страницу в Object Storage и применить сертификат HTTPS,
    В качестве результата предоставить скриншот на страницу с сертификатом в заголовке ("замочек").
### Ответ:
 По первой части задания создал kms ключ и добавил права kms.keys.encrypterDecrypter сервисному аккаунту.   
 [Манифест для терраформа](https://github.com/SSergeyA/devops-netology/blob/main/Kubernetes/22/main.tf)  
 ![image](https://user-images.githubusercontent.com/93119897/222180504-3d0456aa-c4df-4378-98e9-fa36d05b3025.png)

 ![image](https://user-images.githubusercontent.com/93119897/222180439-dfaaa125-9ea8-4668-bb82-cc6b83e95113.png)
![image](https://user-images.githubusercontent.com/93119897/222180603-e025111b-8573-47a6-b12c-d71b0aeeed51.png)

![image](https://user-images.githubusercontent.com/93119897/222180641-e1377cf1-9853-4b5a-827a-e5da8e82df75.png)
![image](https://user-images.githubusercontent.com/93119897/222180739-3daccc6a-36e5-48cc-9f33-9b71d6c31695.png)  

Создал простой index.html и загрузил в статический сайт
![image](https://user-images.githubusercontent.com/93119897/222180812-4834b97f-c2c1-4226-837e-6278fceb0afd.png)
![image](https://user-images.githubusercontent.com/93119897/222181333-14852015-0879-4246-a61e-039c4338b3f3.png)
