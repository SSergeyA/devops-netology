### Sergey Sokolov

## Задача 1
![image](https://user-images.githubusercontent.com/93119897/176451713-cf92bff5-5f9a-4b17-86ae-fad8b107baaf.png)
```
sergey@sergey-ThinkPad-X201:~/terraform$ yc config list
token: AQAAAABgkUTRAATuwde2SJW_
cloud-id: b1gd88frf016p6u7jbkb
folder-id: b1gump4iofj1llimbreg
compute-default-zone: ru-central1-a
```
## Задача 2
Ответ на вопрос: при помощи какого инструмента (из разобранных на прошлом занятии) можно создать свой образ ami? 
При помощи Packer.

![image](https://user-images.githubusercontent.com/93119897/176452572-ec53db8d-f6a4-49d6-9207-44d7b15d1726.png)
![image](https://user-images.githubusercontent.com/93119897/176452637-dc780eac-70ea-41a3-a4c0-26f666a6310c.png)
![image](https://user-images.githubusercontent.com/93119897/176452696-c220a408-b9f6-4a1a-9f01-fc06ea03f542.png)
[main.tf](https://github.com/SSergeyA/devops-netology/blob/main/virt/main.tf) </br>
[versions.tf](https://github.com/SSergeyA/devops-netology/blob/main/virt/versions.tf)
