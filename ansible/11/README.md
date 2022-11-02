# Sergey Sokolov
## Домашнее задание к занятию "09.06 Gitlab"
[Ссылка на репозиторий](https://netology-test.gitlab.yandexcloud.net/sergey/netology-test.git)
### Подготовка к выполнению

-    Необходимо подготовить gitlab к работе по инструкции
-    Создайте свой новый проект
-    Создайте новый репозиторий в gitlab, наполните его файлами
-    Проект должен быть публичным, остальные настройки по желанию
![image](https://user-images.githubusercontent.com/93119897/199538749-825233b6-8252-4815-b98c-b317b0b7bb54.png)
![image](https://user-images.githubusercontent.com/93119897/199538800-eb9e17ce-1b45-4ab0-9b3f-94972c77fb64.png)

### Основная часть
DevOps

В репозитории содержится код проекта на python. Проект - RESTful API сервис. Ваша задача автоматизировать сборку образа с выполнением python-скрипта:

    Образ собирается на основе centos:7
    Python версии не ниже 3.7
    Установлены зависимости: flask flask-restful
    Создана директория /python_api
    Скрипт из репозитория размещён в /python_api
    Точка вызова: запуск скрипта
    Если сборка происходит на ветке master: должен подняться pod kubernetes на основе образа python-api, иначе этот шаг нужно пропустить
![image](https://user-images.githubusercontent.com/93119897/199538867-4196c762-34a3-4cd1-8460-cafdd984ade5.png)

Product Owner

Вашему проекту нужна бизнесовая доработка: необходимо поменять JSON ответа на вызов метода GET /rest/api/get_info, необходимо создать Issue в котором указать:

    Какой метод необходимо исправить
    Текст с { "message": "Already started" } на { "message": "Running"}
    Issue поставить label: feature
![image](https://user-images.githubusercontent.com/93119897/199538944-cc11dfc3-9751-42c8-8725-e34b88732a19.png)
![image](https://user-images.githubusercontent.com/93119897/199538977-567ea166-f908-45d2-b304-47dc20ff4b85.png)

Developer

Вам пришел новый Issue на доработку, вам необходимо:

    Создать отдельную ветку, связанную с этим issue
    Внести изменения по тексту из задания
    Подготовить Merge Requst, влить необходимые изменения в master, проверить, что сборка прошла успешно
![image](https://user-images.githubusercontent.com/93119897/199539056-7ee6e29a-8500-47f3-b191-230011d47326.png)
![image](https://user-images.githubusercontent.com/93119897/199539077-64ae6446-addc-467f-8e24-56c2b8de8aa2.png)

Tester

Разработчики выполнили новый Issue, необходимо проверить валидность изменений:

    Поднять докер-контейнер с образом python-api:latest и проверить возврат метода на корректность
    Закрыть Issue с комментарием об успешности прохождения, указав желаемый результат и фактически достигнутый
![image](https://user-images.githubusercontent.com/93119897/199539158-29dab2c7-c755-4a37-a90e-6f6589e84bec.png)
![image](https://user-images.githubusercontent.com/93119897/199539197-bea382b9-2b36-447b-aa4d-852eae010842.png)
![image](https://user-images.githubusercontent.com/93119897/199539485-80b2a3a1-e7f9-4ddb-925a-00f314de5c3a.png)
