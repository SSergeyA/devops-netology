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
