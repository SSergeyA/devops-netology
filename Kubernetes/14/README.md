# Sergey Sokolov
## Домашнее задание к занятию "13.5 поддержка нескольких окружений на примере Qbec"

Приложение обычно существует в нескольких окружениях. Для удобства работы следует использовать соответствующие инструменты, например, Qbec.
### Задание 1: подготовить приложение для работы через qbec

Приложение следует упаковать в qbec. Окружения должно быть 2: stage и production.

Требования:

    stage окружение должно поднимать каждый компонент приложения в одном экземпляре;
    production окружение — каждый компонент в трёх экземплярах;
    для production окружения нужно добавить endpoint на внешний адрес.  

Установил qbec создал [конфигурацию]() со структурой  для наполнения.
![image](https://user-images.githubusercontent.com/93119897/205438968-cb3a92ee-faa0-4b28-8020-a8979e5c1bd3.png)

Перенес через yaml jsonnet конвертер манифесты и раскидал по соответствующим файлам. Затем проверил, что они собираются и исправил ошибки.  
![image](https://user-images.githubusercontent.com/93119897/205439067-a5528264-230f-4bc8-bbb6-9004546eb4da.png)
![image](https://user-images.githubusercontent.com/93119897/205439075-0c86f5af-5499-4318-831f-0d0d2484605e.png)
![image](https://user-images.githubusercontent.com/93119897/205439090-37efbad3-f66a-44cf-8b27-27680c680751.png)
![image](https://user-images.githubusercontent.com/93119897/205439096-4988b186-2754-44cc-80a7-0e0bfbc27559.png)
Создал неймспейсы и задеплоил приложение в стейдж.  
![image](https://user-images.githubusercontent.com/93119897/205439113-d9959b4a-4c36-403c-a435-6bd4103c70bb.png)
![image](https://user-images.githubusercontent.com/93119897/205439117-5f632d9e-37b6-4617-a935-340a71d1e6df.png)
Создал прод и проверил наличие эндпоинт на внешний адрес.
![image](https://user-images.githubusercontent.com/93119897/205439146-32ef73fe-ee5c-4211-aec7-6bba06b26cf3.png)
![image](https://user-images.githubusercontent.com/93119897/205439167-8ecdb299-8d93-4df8-850b-e9c8ada4da38.png)
