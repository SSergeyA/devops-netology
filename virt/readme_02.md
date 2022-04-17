### Sokolov Sergey
# Домашнее задание к занятию "5.2. Применение принципов IaaC в работе с виртуальными машинами"


## Задача 1
  Применение патернов применяемых при подходе разработки "структура как код" позволяет ускорить процесс разработки ПО: 
все обновления сливаются потом в одну ветку автоматически, его отладки, и исправления ошибок и выхода на рынок. Так же использование 
патернов позволяет людям, приходящим в команду, быстрей понимать механизмы разработки ПО.
  Как я понял из лекции все 3 принципа IaaC являютя основопологающими, какой то один или два выделить нельзя.

## Задача 2
  Думаю, что сновным преимуществом Ansible является подключение к хостам по SSH, без установки клиентов, так же плюсом является
использование Phyton, т.к. он встроен в ОС Unix/Linux. И простота его использования программистами и системными админитраторами.
Покрайней мере, как я понимаю,к этому стремяться разработчики.
    Более надежным является Push, так как при этом методе изменение конфигурации инициализирует управляющий сервер. Не факт ,
что при pull методе,     хост сам в нужный момент запросит конфигурацию.

## Задача 3
```
sergey@sergey-ThinkPad-X201:~$ VBoxManage --version
6.1.28r147628
```
```
sergey@sergey-ThinkPad-X201:~/vagrant$ vagrant global-status
id       name    provider   state   directory                           
------------------------------------------------------------------------
a3552d1  default virtualbox running /home/sergey/vagrant                
```
```
sergey@sergey-ThinkPad-X201:~/vagrant$ ansible --version
ansible [core 2.12.4]
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/home/sergey/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  ansible collection location = /home/sergey/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/bin/ansible
  python version = 3.8.10 (default, Mar 15 2022, 12:22:08) [GCC 9.4.0]
  jinja version = 2.10.1
  libyaml = True
```
## Задача 4
```
vagrant@server1:~$ sudo -i
root@server1:~# docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
root@server1:~# uptime
 13:39:26 up 5 min,  1 user,  load average: 0.34, 0.84, 0.47
root@server1:~# 
```
