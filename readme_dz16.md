### Как сдавать задания

Вы уже изучили блок «Системы управления версиями», и начиная с этого занятия все ваши работы будут приниматься ссылками на .md-файлы, размещённые в вашем публичном репозитории.

Скопируйте в свой .md-файл содержимое этого файла; исходники можно посмотреть [здесь](https://raw.githubusercontent.com/netology-code/sysadm-homeworks/devsys10/04-script-03-yaml/README.md). Заполните недостающие части документа решением задач (заменяйте `???`, ОСТАЛЬНОЕ В ШАБЛОНЕ НЕ ТРОГАЙТЕ чтобы не сломать форматирование текста, подсветку синтаксиса и прочее, иначе можно отправиться на доработку) и отправляйте на проверку. Вместо логов можно вставить скриншоты по желани.

# Домашнее задание к занятию "4.3. Языки разметки JSON и YAML"


## Обязательная задача 1
Мы выгрузили JSON, который получили через API запрос к нашему сервису:
```
    { "info" : "Sample JSON output from our service\t",
        "elements" :[
            { "name" : "first",
            "type" : "server",
            "ip" : 7175 
            }
            { "name" : "second",
            "type" : "proxy",
            "ip : 71.78.22.43
            }
        ]
    }
```
  Нужно найти и исправить все ошибки, которые допускает наш сервис
  ```
  { "info" : "Sample JSON output from our service\t",
    "elements" :[
        { "name" : "first",
        "type" : "server",
        "ip" : 7175 
        }
        { "name" : "second",
        "type" : "proxy",
        "ip" : "71.78.22.43" - Не хватало кавычек , т.к. это строка
        }
    ]
}
```

## Обязательная задача 2
В прошлый рабочий день мы создавали скрипт, позволяющий опрашивать веб-сервисы и получать их IP. К уже реализованному функционалу нам нужно добавить возможность записи JSON и YAML файлов, описывающих наши сервисы. Формат записи JSON по одному сервису: `{ "имя сервиса" : "его IP"}`. Формат записи YAML по одному сервису: `- имя сервиса: его IP`. Если в момент исполнения скрипта меняется IP у сервиса - он должен так же поменяться в yml и json файле.

### Ваш скрипт:
```python
!/usr/bin/env python3


import time
import socket
import json
import yaml

iptable = {}
a=1

hostname = ['drive.google.com', 'mail.google.com', 'google.com']
for host in hostname:
 iptable[host] = socket.gethostbyname(host)
 print ( host, '-',  iptable[host])
print (iptable)
with open("data.json", "w") as js_file:
    json.dump(iptable, js_file, indent=2)
with open("data.yaml", "w") as ym_file:
    ym_file.write(yaml.dump( iptable, indent=2,explicit_start=True, explicit_end=True))
while a != 0:
    for host in hostname:
        if iptable[host] != socket.gethostbyname(host):
             print ('[ERROR]', host ,'IP mismatch:', iptable[host] , socket.gethostbyname(host))
             iptable[host] = socket.gethostbyname(host)
             with open("data.json", "w") as js_file:
                json.dump(iptable, js_file, indent=2)
             with open("data.yaml", "w") as ym_file:
                ym_file.write(yaml.dump( iptable, indent=2,explicit_start=True, explicit_end=True))
        time.sleep(5)
```

### Вывод скрипта при запуске при тестировании:
```
sergey@sergey-ThinkPad-X201:~/devops-netology$ ./pingjson.py
drive.google.com - 64.233.165.113
mail.google.com - 64.233.163.17
google.com - 64.233.161.100
{'drive.google.com': '64.233.165.113', 'mail.google.com': '64.233.163.17', 'google.com': '64.233.161.100'}
[ERROR] drive.google.com IP mismatch: 64.233.165.113 64.233.165.139
[ERROR] google.com IP mismatch: 64.233.161.100 64.233.161.138
```

### json-файл(ы), который(е) записал ваш скрипт:
```json
{
  "drive.google.com": "64.233.165.139",
  "mail.google.com": "64.233.163.17",
  "google.com": "64.233.161.138"
}
```

### yml-файл(ы), который(е) записал ваш скрипт:
```yaml
---
drive.google.com: 64.233.165.139
google.com: 64.233.161.138
mail.google.com: 64.233.163.17
...

```
