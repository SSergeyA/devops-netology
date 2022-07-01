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
Вывод terraform apply
![image](https://user-images.githubusercontent.com/93119897/176892840-38d05e38-ed2f-4487-b4b3-8b646808c07c.png)</br>
Проверил в консоли яндекс облака
![image](https://user-images.githubusercontent.com/93119897/176892987-29959182-50c2-426e-87f3-98fe3c53950c.png)
![image](https://user-images.githubusercontent.com/93119897/176893063-a23237c4-9ca8-49d9-8778-2d7e1cb136d2.png)
![image](https://user-images.githubusercontent.com/93119897/176893160-9b403420-f814-437b-9fb6-90ccba95686e.png)
![image](https://user-images.githubusercontent.com/93119897/176893227-d2db724e-9e7b-4a03-8c08-b1343e03ebfc.png)



