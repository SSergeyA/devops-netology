# Sergey Sokolov
## Домашнее задание к занятию "13.3 работа с kubectl"
### Задание 1: проверить работоспособность каждого компонента

Для проверки работы можно использовать 2 способа: port-forward и exec. Используя оба способа, проверьте каждый компонент:

    сделайте запросы к бекенду;
    сделайте запросы к фронту;
    подключитесь к базе данных.
![image](https://user-images.githubusercontent.com/93119897/204793299-af4f86e6-1cc0-4b99-b426-a74b05063078.png)
![image](https://user-images.githubusercontent.com/93119897/204793391-6bf6b0bf-f84c-42ec-9a20-d01f53097b24.png)
![image](https://user-images.githubusercontent.com/93119897/204793416-b1a9bde9-1483-4bad-81db-de46566fd021.png)
Попробовал перенаправить и на сервис и на под.
![image](https://user-images.githubusercontent.com/93119897/204793547-bb4c6fbe-3bf9-42d7-9bf6-9a2a3075aba4.png)
![image](https://user-images.githubusercontent.com/93119897/204793565-da348c32-0b1d-49e7-9885-b8e0a0d330e4.png)
![image](https://user-images.githubusercontent.com/93119897/204793609-da9ea6a2-420d-4fe8-9a21-2563a39b89c1.png)
![image](https://user-images.githubusercontent.com/93119897/204793628-eb566714-2a77-429d-ac6d-4e7937b41a7e.png)

### Задание 2: ручное масштабирование

При работе с приложением иногда может потребоваться вручную добавить пару копий. Используя команду kubectl scale, попробуйте увеличить количество бекенда и фронта до 3. Проверьте, на каких нодах оказались копии после каждого действия (kubectl describe, kubectl get pods -o wide). После уменьшите количество копий до 1.

Попробовал разными вариантами увеличить а потом уменьшить количество копий.
![image](https://user-images.githubusercontent.com/93119897/204793680-0fef7dc1-52fe-4ddf-a08f-93078ac236f9.png)

