## Sergey Sokolov
### Задание 1
![image](https://user-images.githubusercontent.com/93119897/168298988-1a17ee31-ecd3-4dc2-857a-22defbb961da.png)

### Задание 2
```
create table orders
( id SERIAL PRIMARY key,
  наименование varchar (40),
  цена int
 );
 ```
 ```
 create table clients
( id SERIAL PRIMARY key,
  фамилия varchar (40),
  contry varchar(60), 
  order_id int,
  FOREIGN key (order_id) references orders (id)
 );
 ```
![image](https://user-images.githubusercontent.com/93119897/170460986-1dbcb068-1b54-4e15-9190-710d452747c9.png)

![image](https://user-images.githubusercontent.com/93119897/170460565-06d514bb-bb1a-4689-aceb-e44c329b18b9.png)

![image](https://user-images.githubusercontent.com/93119897/170464719-891bdfc6-4dbe-4eb6-8697-dcc3dcc7901a.png)

### Задание 3
![image](https://user-images.githubusercontent.com/93119897/170483253-e78b51bc-e5ef-40a6-b06e-b2adecacd1c0.png)

### Задание 4
![image](https://user-images.githubusercontent.com/93119897/170487229-1df7987c-e2b7-4517-a557-4434b04b7e68.png)

### Задание 5
![image](https://user-images.githubusercontent.com/93119897/170488471-d2e84bea-a157-4936-ae6e-975337325868.png)
Показывается, что при запросе выбран простой план сканирования. Указана приблизительная стоимость запкска и общая стоимость,
ожидаемое число строк и средний размер строки. 
Показано, что применено условие not null  как фильтр к узлу плана сканирования.
### Задание 6
Создаем бэкап в работающем контейнере `sudo docker exec -t 0b1f68e38545 bash -c 'pg_dump -U pg  test_db > /var/lib/postgresql/backup/test_db.sql'
`
![image](https://user-images.githubusercontent.com/93119897/170550697-6ac2625a-52b6-4e6f-bf73-a9b2093d020b.png)
Все восстановилось, кроме ролей. Тут я немного не понял, почему роли не восстановились. Точнее, понятно, что в новом контейнере с postgree, этих ролей нет, и от сюда ошибка в создании прав на таблицы данным пользователям. Не совсем понял, как тогда сделать бекап чтоб все пренеслось, вместе с созданием этих ролей  
![image](https://user-images.githubusercontent.com/93119897/170551149-5bc2339c-9827-444f-b4c4-aa1bff97974c.png)
![image](https://user-images.githubusercontent.com/93119897/170551383-0834545c-e160-4f54-a50b-b55c8915223a.png)

