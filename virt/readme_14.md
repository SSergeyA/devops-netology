### Sergey Sokolov

## Задача 1

Создал статический ключ доступа для сервис аккаунта  (аккаунт у меня был создан на предыдущем занятии). 
```
sergey@sergey-ThinkPad-X201:~/terraform$ yc iam access-key create --service-account-name my-robot
access_key:
  id: ajel541bvfa6ri0ennel
  service_account_id: aje         7ls44
  created_at: "2022-07-01T08:21:57.794055955Z"
  key_id: YCA          6jg7
secret: YCPz               o_3wmj
```
Затем в отдельном каталоге создал файл [main.tf](https://github.com/SSergeyA/devops-netology/blob/main/virt/14/main.tf)

![image](https://user-images.githubusercontent.com/93119897/176890727-7f9a3a47-3eff-4837-90a0-0f3649addd4c.png)
![image](https://user-images.githubusercontent.com/93119897/176890921-85133322-ccb8-4679-83a8-60516f86b815.png)
![image](https://user-images.githubusercontent.com/93119897/176891114-cff9286d-1235-473e-9381-6883fb973119.png)


## Задача 2 

[main.tf](https://github.com/SSergeyA/devops-netology/blob/main/virt/14/main%20(copy).tf) </br>
[s3.tf](https://github.com/SSergeyA/devops-netology/blob/main/virt/14/s3.tf)</br>
Вывод terraform plan очень длинный , я сохранил его в файл, вместо скриншотов [terraform plan](https://github.com/SSergeyA/devops-netology/blob/main/terraform.plan) </br>

