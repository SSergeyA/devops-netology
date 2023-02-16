# Sergey Sokolov
## Задание 1. Яндекс.Облако (обязательное к выполнению)

    Создать bucket Object Storage и разместить там файл с картинкой:

    Создать bucket в Object Storage с произвольным именем (например, имя_студента_дата);
    Положить в bucket файл с картинкой;
    Сделать файл доступным из Интернет.

    Создать группу ВМ в public подсети фиксированного размера с шаблоном LAMP и web-страничкой, содержащей ссылку на картинку из bucket:

    Создать Instance Group с 3 ВМ и шаблоном LAMP. Для LAMP рекомендуется использовать image_id = fd827b91d99psvq5fjit;
    Для создания стартовой веб-страницы рекомендуется использовать раздел user_data в meta_data;
    Разместить в стартовой веб-странице шаблонной ВМ ссылку на картинку из bucket;
    Настроить проверку состояния ВМ.

    Подключить группу к сетевому балансировщику:

    Создать сетевой балансировщик;
    Проверить работоспособность, удалив одну или несколько ВМ.

    *Создать Application Load Balancer с использованием Instance group и проверкой состояния.

Документация

    Compute instance group
    Network Load Balancer
    Группа ВМ с сетевым балансировщиком


Пример bootstrap-скрипта:   
```
#!/bin/bash
yum install httpd -y
service httpd start
chkconfig httpd on
cd /var/www/html
echo "<html><h1>My cool web-server</h1></html>" > index.html
```    
## Выполнение   
Запустил [скрипт]() чтобы добавить в переменные окружения credentials    
Потом запустил манифест [терраформ]() и проверил. что открывается картинка при одном выключенном сервере (я попробовал и поставил доустимым 2 вылючнных, тоже работает)    
![image](https://user-images.githubusercontent.com/93119897/219434877-878aa498-835a-402f-b398-7e29a63d4fb0.png)
![image](https://user-images.githubusercontent.com/93119897/219434911-8a3e6bc3-81c7-4077-9df1-d37e05df7d81.png)
![image](https://user-images.githubusercontent.com/93119897/219434945-fe65d6c7-72eb-4152-bd83-8c2bdd386e15.png)
