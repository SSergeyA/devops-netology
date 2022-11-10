# Sergey Sokolov
### Домашнее задание к занятию "10.04. ELK"
Дополнительные ссылки

При выполнении задания пользуйтесь вспомогательными ресурсами:

    поднимаем elk в докер
    поднимаем elk в докер с filebeat и докер логами
    конфигурируем logstash
    плагины filter для logstash
    конфигурируем filebeat
    привязываем индексы из elastic в kibana
    как просматривать логи в kibana
    решение ошибки increase vm.max_map_count elasticsearch

В процессе выполнения задания могут возникнуть также не указанные тут проблемы в зависимости от системы.

Используйте output stdout filebeat/kibana и api elasticsearch для изучения корня проблемы и ее устранения.
Задание повышенной сложности

Не используйте директорию help при выполнении домашнего задания.
### Задание 1

Вам необходимо поднять в докере:

    elasticsearch(hot и warm ноды)
    logstash
    kibana
    filebeat

и связать их между собой.

Logstash следует сконфигурировать для приёма по tcp json сообщений.

Filebeat следует сконфигурировать для отправки логов docker вашей системы в logstash.

В директории help находится манифест docker-compose и конфигурации filebeat/logstash для быстрого выполнения данного задания.

Результатом выполнения данного задания должны быть:

    скриншот docker ps через 5 минут после старта всех контейнеров (их должно быть 5)
    скриншот интерфейса kibana
    docker-compose манифест (если вы не использовали директорию help)
    ваши yml конфигурации для стека (если вы не использовали директорию help)
![image](https://user-images.githubusercontent.com/93119897/201173524-05020b58-539a-4de7-9cb2-28f70831b6af.png)
![image](https://user-images.githubusercontent.com/93119897/201173562-8e26acf3-b883-4b91-ae86-d48ed5643709.png)


### Задание 2

Перейдите в меню создания index-patterns в kibana и создайте несколько index-patterns из имеющихся.

Перейдите в меню просмотра логов в kibana (Discover) и самостоятельно изучите как отображаются логи и как производить поиск по логам.

В манифесте директории help также приведенно dummy приложение, которое генерирует рандомные события в stdout контейнера. Данные логи должны порождать индекс logstash-* в elasticsearch. Если данного индекса нет - воспользуйтесь советами и источниками из раздела "Дополнительные ссылки" данного ДЗ.
![image](https://user-images.githubusercontent.com/93119897/201173692-03b90b02-d36e-47a8-9d27-f9a5833557d5.png)
![image](https://user-images.githubusercontent.com/93119897/201173852-9c8da7c0-6461-42b1-9a24-9929b59169bb.png)
