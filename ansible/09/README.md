# Sergey Sokolov
## Домашнее задание к занятию "09.04 Jenkins"

### Подготовка к выполнению

- Создать 2 VM: для jenkins-master и jenkins-agent.
![image](https://user-images.githubusercontent.com/93119897/198350990-adca171c-42e4-409f-972a-ab0e56a963a8.png)
- Установить jenkins при помощи playbook'a.
- Запустить и проверить работоспособность.
![image](https://user-images.githubusercontent.com/93119897/198351344-1fa6fd85-4338-41b1-bd03-1e1680716e3c.png)
- Сделать первоначальную настройку.
![image](https://user-images.githubusercontent.com/93119897/198351607-cf0d5025-ae4a-4a5b-92f6-215548b02aa5.png)
  
### Основная часть

- Сделать Freestyle Job, который будет запускать molecule test из любого вашего репозитория с ролью.
![image](https://user-images.githubusercontent.com/93119897/198352161-238cb3e3-cd53-4bce-8e0e-9e060b3bbe24.png)
![image](https://user-images.githubusercontent.com/93119897/198352363-1f2f9456-ee0c-43ed-89a9-d487b5443536.png)
- Сделать Declarative Pipeline Job, который будет запускать molecule test из любого вашего репозитория с ролью.
![image](https://user-images.githubusercontent.com/93119897/198352458-f27f2dd0-1fd2-451e-a039-01354aa7d3ab.png)
- Перенести Declarative Pipeline в репозиторий в файл Jenkinsfile.
- Создать Multibranch Pipeline на запуск Jenkinsfile из репозитория.
![image](https://user-images.githubusercontent.com/93119897/198352546-922074e6-0fa0-42c8-8e52-8f1569ba251a.png)
- Создать Scripted Pipeline, наполнить его скриптом из pipeline.
- Внести необходимые изменения, чтобы Pipeline запускал ansible-playbook без флагов --check --diff, если не установлен параметр при запуске джобы (prod_run = True), по умолчанию параметр имеет значение False и запускает прогон с флагами --check --diff.
- Проверить работоспособность, исправить ошибки, исправленный Pipeline вложить в репозиторий в файл ScriptedJenkinsfile.
![image](https://user-images.githubusercontent.com/93119897/198352710-599b02e4-8fdf-47a2-a7e6-ed8e683ed645.png)
![image](https://user-images.githubusercontent.com/93119897/198352748-65cfb857-4f65-4b3f-b961-5bc81d354771.png)
![image](https://user-images.githubusercontent.com/93119897/198353672-d19a30f8-9448-40dd-a323-e4bcdb2d161d.png)
- Отправить ссылку на репозиторий с ролью и Declarative Pipeline и Scripted Pipeline.  
[репозиторий с ролью и файлами](https://github.com/SSergeyA/vector-role)
