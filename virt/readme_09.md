### Sergey Sokolov
## Задание1
Вывод списка БД </br>
![image](https://user-images.githubusercontent.com/93119897/172161264-27329c5e-5b16-4423-b8db-928c5512ed3b.png)

Подключение к БД</br>
`\c[onnect] {[DBNAME|- USER|- HOST|- PORT|-] | conninfo}`</br>
![image](https://user-images.githubusercontent.com/93119897/172161769-54fe894d-c9d5-49ad-b944-d50432ea0869.png)
Вывод списка таблиц</br>
`\dt [PATTERN]      list tables` c S выведет системные объекты , + добавит описание
![image](https://user-images.githubusercontent.com/93119897/172162539-fc082360-addc-4043-8369-3ab20c4a9ca3.png)

Вывод описания содержимого таблиц </br>
![image](https://user-images.githubusercontent.com/93119897/172165066-b54f1a6f-b887-47db-9153-96bf3a410808.png)

Выход из psql </br>
`\q                     quit psql`
## Задание2

![image](https://user-images.githubusercontent.com/93119897/172214704-18ace1fd-d4bc-464c-8d44-45f74cc5804e.png)
![image](https://user-images.githubusercontent.com/93119897/172217952-26bce37b-878b-4d53-848b-5e694dee9030.png)

## Задание3
Переименовал таблицу заказов, создал новую пустую, потом создал две для заказов больше и меньше 499 и правила их заполнения, 
наполнил значениями из переименованной таблицы и удалил ее. Исключить ручное разбивание таблиц нужно было еще на этапе проектирования базы. Это правильней и проще.
![image](https://user-images.githubusercontent.com/93119897/172229528-d9d0ceeb-664c-42fe-81de-c5b0d28c56bf.png)

![image](https://user-images.githubusercontent.com/93119897/172229627-59aea793-7bc6-4722-8ae7-70e5bca150f3.png)

![image](https://user-images.githubusercontent.com/93119897/172229674-f3352077-a7f4-4969-965a-a26c50198079.png)

![image](https://user-images.githubusercontent.com/93119897/172229737-32aa0665-becf-4b45-8586-ca6b81dd5f4a.png)
## Задание4
![image](https://user-images.githubusercontent.com/93119897/172232569-d8bd396b-508e-4d68-baa1-e85d1326e524.png)

для создания уникальных индексов в бекап добавить `CREATE UNIQUE INDEX name ON table (column [, ...]);`
CREATE unique INDEX title ON orders (title);
CREATE unique INDEX title ON orders_1 (title);
CREATE unique INDEX title ON orders_2 (title);
