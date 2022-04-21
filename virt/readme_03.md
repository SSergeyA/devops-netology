### Sergey Sokolov
## Задача1
https://hub.docker.com/r/ssergeya/websrv

## Задача2
- Высоконагруженное монолитное java веб-приложениe - для этого приложения лучше всего подойдет физический сервер. Т.к. технология виртуализации подразумевает отказ от монолитных приложений в пользу легких и масштабируемых взаимосвязанных сервисов. Докер, как продолжение виртуализации, нацелен на разбитие приложений на микросервисы , которые выполняют специфичные функиции и связаны с остальными микросервисами приложения по API.
- Nodejs веб-приложение - можно расположить на докере, т.к.  используется для создания быстрых и масштабируемых веб приложений 
- Мобильное приложение c версиями для Android и iOS -не совсем понял, причем тут версии приложений, они же и те и другие отправляют запросы на сервер и получают ответы и интерпиритируют их пользователю. мне кажется тут можно разместить и на виртуальной машине и в контейнере.
- Шина данных на базе Apache Kafka - насколько я понял, тут главное наличие горизонтальной масштабируемости и отказоустойчивости. Значит подойдет как докер так и виртуализация.
- Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana - тоже, не вижу особой разницы как реализовать,можно и на виртуальных серверах, но так же  есть готовые образы для докера. 
- Мониторинг-стек на базе Prometheus и Grafana - тоже самое 
- MongoDB, как основное хранилище данных для java-приложения - мне кажется удобнее разворачивать в контейнерах, но можно и на виртуальных машинах. главное позаботится о сохранении файловых данных.
- Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry - GitLab вполне можно развернуть в Docker, так же как и на виртуальной машине. Про Docker Registry такой информации не нащел, да и не понятно зачем разворачивать модуль предназначенный для хранения и управления образами в контейнере, так что остается для него виртуальная машина.

## Задача3
По задаче есть маленький вопрос: я же мог подключаться вместо EXEC используя ATTACH, что бы не заводить второй процесс баш, а выполнить все в запущенном?  или это не принципиально
```
root@server1:/docker/data# docker ps
CONTAINER ID   IMAGE     COMMAND              CREATED        STATUS        PORTS                               NAMES
ef4c65294b48   websrv    "/bin/sh -c nginx"   31 hours ago   Up 31 hours   0.0.0.0:80->80/tcp, :::80->80/tcp   awesome_kirch
root@server1:/docker/data# ls
root@server1:/docker/data# docker run -it -d -v "/docker/data:/data" centos /bin/bash
e092e2244d96c512c087f629bb8b88cc5510bf3d4f970be88b23b5e2ea67abd1
root@server1:/docker/data# docker run -it -d -v "/docker/data:/data" debian /bin/bash
6dda7bdf284a6140264894152e7b2e2895a6d412a2116c75f367d9bda0cdb6c0
root@server1:/docker/data# docker ps
CONTAINER ID   IMAGE     COMMAND              CREATED              STATUS              PORTS                               NAMES
6dda7bdf284a   debian    "/bin/bash"          About a minute ago   Up About a minute                                       frosty_margulis
e092e2244d96   centos    "/bin/bash"          About a minute ago   Up About a minute                                       tender_yonath
ef4c65294b48   websrv    "/bin/sh -c nginx"   31 hours ago         Up 31 hours         0.0.0.0:80->80/tcp, :::80->80/tcp   awesome_kirch
root@server1:/docker/data# docker exec -it e092e2244d96 /bin/bash
[root@e092e2244d96 /]# echo "test 1" > /data/1.txt
[root@e092e2244d96 /]# exit
exit
root@server1:/docker/data# echo "test 2" > 2.txt
root@server1:/docker/data# ll
total 16
drwxrwxrwx 2 root root 4096 Apr 21 18:01 ./
drwxr-xr-x 4 root root 4096 Apr 21 16:53 ../
-rw-r--r-- 1 root root    7 Apr 21 18:01 1.txt
-rw-r--r-- 1 root root    7 Apr 21 18:01 2.txt
root@server1:/docker/data# docker exec -it 6dda7bdf284a /bin/bash
root@6dda7bdf284a:/# ls /data
1.txt  2.txt
root@6dda7bdf284a:/# 
```
