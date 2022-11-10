# Sergey Sokolov
## Домашнее задание к занятию "10.02. Системы мониторинга"
###Обязательные задания

  #### 1.  Опишите основные плюсы и минусы pull и push систем мониторинга.
  У Push плюсы :  
  - Проще настраивать отправку данных, конечнаые точки отправк задаются на агенте, это удобно при разворачивании динамических инстансов.  
  - Гибкая настройка  частоты отправик и того что отправляется на агенте, можно учесть узкие места каналов связи 
  - Использование UDP повышает производительность отправки данных.  
  Минус:  
  - UDP возможна потеря части данных , или полной потери, например при недоступности сервера мониторинга.  
  -  Сложней контролировать подлинность данных.  
  
   У Pull плюсы :  
  - Легче контролировать подлинность данных. Идет запрос от системы мониторинга к известным агентам.  
  - Можно обезопасить систему монитторинга , используя прокси с TLS
  - Упрощенная отладка получения данных с агентов (так как данные запрашиваются посредством HTTP, можно самостоятельно запрашивать эти данные, используя ПО вне системы мониторинга)
  Минусы:  
  - Менее удобно использовать для динамически создаваемых инстансов.
  - HTTP более затратный способ передачи в сравнении с UDP
  - Менее гибкая настройка отправки пакетов данных с метриками. 

  #### 2. Какие из ниже перечисленных систем относятся к push модели, а какие к pull? А может есть гибридные?
  Prometheus - Pull ( у него есть push geteway, который позволяет собирать собирать метрики как Push, но потом сервер мониторинга забирает как pull.  
  TICK - push (Telegraf можно настроить для работы в  Pull)  
  Zabbix - гибридная   
  VictoriaMetrics - гибридная  
  Nagios -Pull

  #### 3.  Склонируйте себе репозиторий и запустите TICK-стэк, используя технологии docker и docker-compose.(по инструкции ./sandbox up )

В виде решения на это упражнение приведите выводы команд с вашего компьютера (виртуальной машины):

- curl http://localhost:8086/ping
- curl http://localhost:8888
- curl http://localhost:9092/kapacitor/v1/ping
![image](https://user-images.githubusercontent.com/93119897/200283545-6e9bc151-e824-4898-a76c-b907999b9258.png)

А также скриншот веб-интерфейса ПО chronograf (http://localhost:8888).
![image](https://user-images.githubusercontent.com/93119897/200284444-9562a68b-cbf0-4ea1-96cc-2bae88895ab7.png)

P.S.: если при запуске некоторые контейнеры будут падать с ошибкой - проставьте им режим Z, например ./data:/var/lib:Z

#### 4.    Изучите список telegraf inputs
Добавьте в конфигурацию telegraf плагин - disk:
```
    [[inputs.disk]]
      ignore_fs = ["tmpfs", "devtmpfs", "devfs", "iso9660", "overlay", "aufs", "squashfs"]
```
        Так же добавьте в конфигурацию telegraf плагин - mem:
```
    [[inputs.mem]]
```
После настройки перезапустите telegraf.

Перейдите в веб-интерфейс Chronograf (http://localhost:8888) и откройте вкладку Data explorer.

Нажмите на кнопку Add a query

Изучите вывод интерфейса и выберите БД telegraf.autogen

В measurments выберите mem->host->telegraf_container_id , а в fields выберите used_percent. Внизу появится график утилизации оперативной памяти в контейнере telegraf.
![image](https://user-images.githubusercontent.com/93119897/200320916-0a1ea039-edaa-4482-aa16-d2ad28a8b2e1.png)

Вверху вы можете увидеть запрос, аналогичный SQL-синтаксису. Поэкспериментируйте с запросом, попробуйте изменить группировку и интервал наблюдений.

Приведите скриншот с отображением метрик утилизации места на диске (disk->host->telegraf_container_id) из веб-интерфейса.
![image](https://user-images.githubusercontent.com/93119897/200320990-1d29abe6-ee69-4065-92ae-79b35f82def4.png)

Добавьте в конфигурацию telegraf следующий плагин - docker:
```
[[inputs.docker]]
  endpoint = "unix:///var/run/docker.sock"
```
Дополнительно вам может потребоваться донастройка контейнера telegraf в docker-compose.yml дополнительного volume и режима privileged:
```
  telegraf:
    image: telegraf:1.4.0
    privileged: true
    volumes:
      - ./etc/telegraf.conf:/etc/telegraf/telegraf.conf:Z
      - /var/run/docker.sock:/var/run/docker.sock:Z
    links:
      - influxdb
    ports:
      - "8092:8092/udp"
      - "8094:8094"
      - "8125:8125/udp"
```
После настройки перезапустите telegraf, обновите веб интерфейс и приведите скриншотом список measurments в веб-интерфейсе базы telegraf.autogen . Там должны появиться метрики, связанные с docker.

![image](https://user-images.githubusercontent.com/93119897/200321089-db2469a9-a5bb-45c7-bac1-2d83fc5f1573.png)

#### 5. Факультативно можете изучить какие метрики собирает telegraf после выполнения данного задания.
Дополнительное задание (со звездочкой*) - необязательно к выполнению

В веб-интерфейсе откройте вкладку Dashboards. Попробуйте создать свой dashboard с отображением:

- утилизации ЦПУ
- количества использованного RAM
- утилизации пространства на дисках
- количество поднятых контейнеров
- аптайм
- ...
- фантазируйте)
![image](https://user-images.githubusercontent.com/93119897/200321153-c4d0b47b-b3de-4763-9d82-a0af1cbdc3c8.png)

---