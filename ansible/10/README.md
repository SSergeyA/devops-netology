# Sergey Sokolov
## Домашнее задание к занятию "09.05 Teamcity"
[Ссылка на репозиторий](https://github.com/SSergeyA/example-teamcity.git)
### Подготовка к выполнению
- В Ya.Cloud создайте новый инстанс (4CPU4RAM) на основе образа jetbrains/teamcity-server 
- Дождитесь запуска teamcity, выполните первоначальную настройку 
- Создайте ещё один инстанс(2CPU4RAM) на основе образа jetbrains/teamcity-agent. Пропишите к нему переменную окружения SERVER_URL: "http://<teamcity_url>:8111" 
- Авторизуйте агент 
- Сделайте fork репозитория 
- Создать VM (2CPU4RAM) и запустить playbook 
![image](https://user-images.githubusercontent.com/93119897/199052916-00b7e78f-3887-45bb-8b43-0ed029160b67.png)
![image](https://user-images.githubusercontent.com/93119897/199053000-54cd89a8-403f-46c9-9b59-64393e14f5be.png)


### Основная часть
- Создайте новый проект в teamcity на основе fork
- Сделайте autodetect конфигурации
- Сохраните необходимые шаги, запустите первую сборку master'a
- Поменяйте условия сборки: если сборка по ветке master, то должен происходит mvn clean deploy, иначе mvn clean test
- Для deploy будет необходимо загрузить settings.xml в набор конфигураций maven у teamcity, предварительно записав туда креды для подключения к nexus
![image](https://user-images.githubusercontent.com/93119897/199053121-fe31ffd4-3bfc-4e0e-9886-1532d7f837f3.png)

- В pom.xml необходимо поменять ссылки на репозиторий и nexus
- Запустите сборку по master, убедитесь что всё прошло успешно, артефакт появился в nexus
![image](https://user-images.githubusercontent.com/93119897/199053403-1203c4b3-7697-45f5-a3db-0335f5f47294.png)
![image](https://user-images.githubusercontent.com/93119897/199053451-5b0487f4-41fe-42ad-b8ee-03589e34de6d.png)

- Мигрируйте build configuration в репозиторий
![image](https://user-images.githubusercontent.com/93119897/199053578-b8d7164f-d71d-4721-8137-056e6d45ac5e.png)

- Создайте отдельную ветку feature/add_reply в репозитории
- Напишите новый метод для класса Welcomer: метод должен возвращать произвольную реплику, содержащую слово hunter
![image](https://user-images.githubusercontent.com/93119897/199053776-5bd5b550-9c4d-4662-ae0f-456f6e0b0062.png)

- Дополните тест для нового метода на поиск слова hunter в новой реплике
![image](https://user-images.githubusercontent.com/93119897/199053848-e99024a4-2c15-4449-91b6-b171b37010dc.png)

- Сделайте push всех изменений в новую ветку в репозиторий
- Убедитесь что сборка самостоятельно запустилась, тесты прошли успешно
![image](https://user-images.githubusercontent.com/93119897/199053934-dc1704a3-00f0-4483-a434-1e51cafe1e5c.png)

- Внесите изменения из произвольной ветки feature/add_reply в master через Merge
- Убедитесь, что нет собранного артефакта в сборке по ветке master
- Настройте конфигурацию так, чтобы она собирала .jar в артефакты сборки
- Проведите повторную сборку мастера, убедитесь, что сбора прошла успешно и артефакты собраны
![image](https://user-images.githubusercontent.com/93119897/199054064-1a6c463f-3801-4a86-bc41-c3c2ff6534b5.png)
![image](https://user-images.githubusercontent.com/93119897/199054119-8dd2f3db-c1c1-4273-9553-42e496e707cf.png)

- Проверьте, что конфигурация в репозитории содержит все настройки конфигурации из teamcity
- В ответ предоставьте ссылку на репозиторий

