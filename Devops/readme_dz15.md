# Sergey Sokolov
# Домашнее задание к занятию "4.2. Использование Python для решения типовых DevOps задач"

## Обязательная задача 1

Есть скрипт:
```python
#!/usr/bin/env python3
a = 1
b = '2'
c = a + b
```
### Вопросы:
| Вопрос  | Ответ |
| ------------- | ------------- |
| Какое значение будет присвоено переменной `c`?  | никакое,будет ошибка. тк разные типы переменых a и b |
| Как получить для переменной `c` значение 12?  | c = str(a) + b|
| Как получить для переменной `c` значение 3?  | c = a + int(b)|

## Обязательная задача 2
Мы устроились на работу в компанию, где раньше уже был DevOps Engineer. Он написал скрипт, позволяющий узнать, какие файлы модифицированы в репозитории, относительно локальных изменений. Этим скриптом недовольно начальство, потому что в его выводе есть не все изменённые файлы, а также непонятен полный путь к директории, где они находятся. Как можно доработать скрипт ниже, чтобы он исполнял требования вашего руководителя?

```python
#!/usr/bin/env python3

import os

bash_command = ["cd ~/netology/sysadm-homeworks", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(prepare_result)
        break
```

### Ваш скрипт:
```python
#!/usr/bin/env python3

import os
import pathlib
bash_command = ["cd ~/devops-netology", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(pathlib.Path.home(),bash_command[0].replace('cd ~/',''),prepare_result, sep='/')
```

### Вывод скрипта при запуске при тестировании:
```
sergey@sergey-ThinkPad-X201:~/devops-netology$ ./p1.py
/home/sergey/devops-netology/README.md
/home/sergey/devops-netology/branching/merge.sh
sergey@sergey-ThinkPad-X201:~/devops-netology$ 
```

## Обязательная задача 3
1. Доработать скрипт выше так, чтобы он мог проверять не только локальный репозиторий в текущей директории, а также умел воспринимать путь к репозиторию, который мы передаём как входной параметр. Мы точно знаем, что начальство коварное и будет проверять работу этого скрипта в директориях, которые не являются локальными репозиториями.

### Ваш скрипт:
```python
#!/usr/bin/env python3

import os
import sys


if len(sys.argv) > 1:
    x = sys.argv[1]
else: 
    x = os.getcwd()
print ("Проверяемая директория:",x)
bash_command = ["cd "+ x, "git status 2>&1" , ]
result_os = os.popen(' && '.join(bash_command)).read()
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(x,prepare_result, sep='/')
    if result.find('fatal') != -1:
        print ('Директория не является локальным репозиторием')
```

### Вывод скрипта при запуске при тестировании:
```
sergey@sergey-ThinkPad-X201:~/devops-netology$ ./p1.py
Проверяемая директория: /home/sergey/devops-netology
/home/sergey/devops-netology/README.md
/home/sergey/devops-netology/branching/merge.sh
sergey@sergey-ThinkPad-X201:~/devops-netology$ ./p1.py ~/test
Проверяемая директория: /home/sergey/test
Директория не является локальным репозиторием
sergey@sergey-ThinkPad-X201:~/devops-netology$ ./p1.py ~/devops-netology
Проверяемая директория: /home/sergey/devops-netology
/home/sergey/devops-netology/README.md
/home/sergey/devops-netology/branching/merge.sh
sergey@sergey-ThinkPad-X201:~/devops-netology$ 
```

## Обязательная задача 4
1. Наша команда разрабатывает несколько веб-сервисов, доступных по http. Мы точно знаем, что на их стенде нет никакой балансировки, кластеризации, за DNS прячется конкретный IP сервера, где установлен сервис. Проблема в том, что отдел, занимающийся нашей инфраструктурой очень часто меняет нам сервера, поэтому IP меняются примерно раз в неделю, при этом сервисы сохраняют за собой DNS имена. Это бы совсем никого не беспокоило, если бы несколько раз сервера не уезжали в такой сегмент сети нашей компании, который недоступен для разработчиков. Мы хотим написать скрипт, который опрашивает веб-сервисы, получает их IP, выводит информацию в стандартный вывод в виде: <URL сервиса> - <его IP>. Также, должна быть реализована возможность проверки текущего IP сервиса c его IP из предыдущей проверки. Если проверка будет провалена - оповестить об этом в стандартный вывод сообщением: [ERROR] <URL сервиса> IP mismatch: <старый IP> <Новый IP>. Будем считать, что наша разработка реализовала сервисы: `drive.google.com`, `mail.google.com`, `google.com`.

### Ваш скрипт:
```python
#!/usr/bin/env python3

import time
import socket

iptable = {}
a=1

hostname = ['drive.google.com', 'mail.google.com', 'google.com']
for host in hostname:
 iptable[host] = socket.gethostbyname(host)
 print ( host, '-',  iptable[host])
while a != 0:
    for host in hostname:
        if iptable[host] != socket.gethostbyname(host):
             print ('[ERROR]', host ,'IP mismatch:', iptable[host] , socket.gethostbyname(host))
             iptable[host] = socket.gethostbyname(host)
        time.sleep(5)
```

### Вывод скрипта при запуске при тестировании:
```
sergey@sergey-ThinkPad-X201:~/devops-netology$ ./4.py
drive.google.com - 64.233.165.194
mail.google.com - 173.194.222.18
google.com - 64.233.162.139
[ERROR] mail.google.com IP mismatch: 173.194.222.18 64.233.165.83
[ERROR] drive.google.com IP mismatch: 64.233.165.194 64.233.162.194
```
