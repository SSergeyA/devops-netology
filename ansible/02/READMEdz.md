
### Description
Данный playboock устанавливает clickhouse и vector.

### Requirements

None
### Role Variables

    vector_version - версия vector, которая будет установлена
    clickhouse_version: - версия clickhouse
 
## Sergey Sokolov
### Домашнее задание к занятию "08.02 Работа с Playbook"
1 . Приготовьте свой собственный inventory файл prod.yml.
```
   ---
clickhouse:
  hosts:
    clickhouse-01:
      ansible_host: 158.160.9.200
```
![image](https://user-images.githubusercontent.com/93119897/192157822-09b307d4-d97f-4af8-a07d-c8014e9f8c24.png)

2. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает vector.
 
```
       - name: Vector  unpack distrib
      ansible.builtin.unarchive:
        src: "./vector-{{ vector_version }}-x86_64-unknown-linux-musl.tar.gz"
        dest: "./"
        remote_src: true
    - name: Install vector
      become: true
      ansible.builtin.copy:
        src: "vector-x86_64-unknown-linux-musl/bin/vector"
        dest: "/usr/local/bin/"
        remote_src: true
        mode: "755"
    - name: Template
      ansible.builtin.template:
        src: vector.cfg.j2
        dest: "vector-x86_64-unknown-linux-musl/config/vector.cfg"
        mode: "755"
 ```
   ![image](https://user-images.githubusercontent.com/93119897/192157840-c8350fe9-f166-4524-94b3-0d1abad97db3.png)
    
 3. Запустите ansible-lint site.yml и исправьте ошибки, если они есть.
![image](https://user-images.githubusercontent.com/93119897/192157946-eca31660-6b17-4d78-8f86-ace8f75a6081.png)

 4. Попробуйте запустить playbook на этом окружении с флагом --check.
 ```
 sergey@sergey-ThinkPad-X201:~/dz/ansible/02/playbook$ ansible-playbook -i inventory/prod.yml site.yml --check

PLAY [Install Clickhouse] ************************************************************************************

TASK [Gathering Facts] ***************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] ********************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 1000, "group": "sergey", "item": "clickhouse-common-static", "mode": "0664", "msg": "Request failed", "owner": "sergey", "response": "HTTP Error 404: Not Found", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 246310036, "state": "file", "status_code": 404, "uid": 1000, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib] ********************************************************************************
ok: [clickhouse-01]

TASK [Install clickhouse packages] ***************************************************************************
ok: [clickhouse-01]

TASK [Start clickhouse service] ******************************************************************************
ok: [clickhouse-01]

TASK [Create database] ***************************************************************************************
skipping: [clickhouse-01]

PLAY [Install Vector] ****************************************************************************************

TASK [Gathering Facts] ***************************************************************************************
ok: [clickhouse-01]

TASK [Get verctor distrib] ***********************************************************************************
ok: [clickhouse-01]

TASK [Vector  unpack distrib] ********************************************************************************
skipping: [clickhouse-01]

TASK [Install vector] ****************************************************************************************
ok: [clickhouse-01]

TASK [Template] **********************************************************************************************
ok: [clickhouse-01]

PLAY RECAP ***************************************************************************************************
clickhouse-01              : ok=8    changed=0    unreachable=0    failed=0    skipped=2    rescued=1    ignored=0   

sergey@sergey-ThinkPad-X201:~/dz/ansible/02/playbook$ 
```
 5. Запустите playbook на prod.yml окружении с флагом --diff. Убедитесь, что изменения на системе произведены.
 ```
 sergey@sergey-ThinkPad-X201:~/dz/ansible/02/playbook$ ansible-playbook -i inventory/prod.yml site.yml --diff

PLAY [Install Clickhouse] ************************************************************************************

TASK [Gathering Facts] ***************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] ********************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 1000, "group": "sergey", "item": "clickhouse-common-static", "mode": "0664", "msg": "Request failed", "owner": "sergey", "response": "HTTP Error 404: Not Found", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 246310036, "state": "file", "status_code": 404, "uid": 1000, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib] ********************************************************************************
ok: [clickhouse-01]

TASK [Install clickhouse packages] ***************************************************************************
ok: [clickhouse-01]

TASK [Start clickhouse service] ******************************************************************************
ok: [clickhouse-01]

TASK [Create database] ***************************************************************************************
ok: [clickhouse-01]

PLAY [Install Vector] ****************************************************************************************

TASK [Gathering Facts] ***************************************************************************************
ok: [clickhouse-01]

TASK [Get verctor distrib] ***********************************************************************************
ok: [clickhouse-01]

TASK [Vector  unpack distrib] ********************************************************************************
ok: [clickhouse-01]

TASK [Install vector] ****************************************************************************************
ok: [clickhouse-01]

TASK [Template] **********************************************************************************************
ok: [clickhouse-01]

PLAY RECAP ***************************************************************************************************
clickhouse-01              : ok=10   changed=0    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0   

sergey@sergey-ThinkPad-X201:~/dz/ansible/02/playbook$ 
``` 
