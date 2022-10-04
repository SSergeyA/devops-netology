### Sergey Sokolov
## Домашнее задание к занятию "08.03 Использование Yandex Cloud"
1. Подготовьте в Yandex Cloud три хоста: для clickhouse, для vector и для lighthouse.
![image](https://user-images.githubusercontent.com/93119897/193917616-9f063402-4a3f-4b1f-a5fc-6741d9def329.png)
2. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает lighthouse.
```
- name: Install Nginx 
  hosts: lighthouse
  handlers: 
    - name: reload-nginx
      become: true
      command: nginx -s reload
  tasks:
    - name: Install EPEL
      become: true
      ansible.builtin.yum:
        name: "epel-release"
        state: latest
    - name: Install Nginx & Git
      become: true
      ansible.builtin.yum:
        name:
          - nginx
          - git
        state: latest
      notify: reload-nginx  
    - name: Nginx config
      become: true
      template: 
        src: templates/nginx.conf.j2
        dest: /etc/nginx/nginx.conf
        mode: 0755
      notify: reload-nginx    
    - name: Autorun Nginx
      become: true
      ansible.builtin.systemd:
        name: nginx
        enabled: yes
    - name: Install FireWall
      become: true
      ansible.builtin.yum:
        name: "firewalld"
        state: latest
    - name: Start FireWall
      become: true
      ansible.builtin.systemd:
        name: firewalld
        state: started
    - name: Upgrade FireWall
      become: true
      ansible.builtin.command:
        cmd: "{{ item }}"
      with_items:
        - firewall-cmd --zone=public --permanent --add-service=http
        - firewall-cmd --zone=public --permanent --add-service=https
        - firewall-cmd --reload
- name: Install lighthouse
  hosts: lighthouse
  handlers: 
    - name: reload-nginx
      become: true
      command: nginx -s reload
  tasks:
   - name: Lighthose copy from git
     git:
       repo: "{{ lighthouse_vcs }}"
       version: master
       dest: "{{ lighthouse_location_dir }}"
   - name: lighthouse config
     become: true
     template:
        src: lighthouse.conf.j2
        dest: /etc/nginx/conf.d/default.conf
        mode: 0755
     notify: reload-nginx
  ```
  3. Приготовьте свой собственный inventory файл prod.yml.
Запустите ansible-lint site.yml и исправьте ошибки, если они есть.
![image](https://user-images.githubusercontent.com/93119897/193919111-b087e097-bb4c-401e-97e7-09cab37f29ce.png)
![image](https://user-images.githubusercontent.com/93119897/193920198-9f83e41e-6438-4b99-b107-82aa95a8cc1b.png)
![image](https://user-images.githubusercontent.com/93119897/193921496-29bfcbb7-eb12-4f31-899f-eb8dd22a6258.png)

