# Самоконтроль выполненения задания

1. Где расположен файл с `some_fact` из второго пункта задания? </br>
   
   В папке `group_vars`, расположены папки соответствующие определенным группам хостов, и уже в них есть файл `examp.yml`,
   в котором описывается значение переменной.</br>

2. Какая команда нужна для запуска вашего `playbook` на окружении `test.yml`?
    
    `ansible-playbook -i inventory/test.yml site.yml` 

3. Какой командой можно зашифровать файл?

    `ansible-vault encrypt`
    
4. Какой командой можно расшифровать файл?

    `ansible-vacult decrypt`

5. Можно ли посмотреть содержимое зашифрованного файла без команды расшифровки файла? Если можно, то как?

  Думаю, что нет. Т.к. при выполнении playbook ansible не расшифровывает файл на диске, а делает это в оперативной памяти, 
  использует и потом высвобождает память. </br>
6. Как выглядит команда запуска `playbook`, если переменные зашифрованы?

    `ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass`
    
7. Как называется модуль подключения к host на windows?

     ```
     winrm                          Run tasks over Microsoft's WinRM 
     ```
8. Приведите полный текст команды для поиска информации в документации ansible для модуля подключений ssh

    `ansible-doc -t connection ssh`

9. Какой параметр из модуля подключения `ssh` необходим для того, чтобы определить пользователя, под которым необходимо совершать подключение?
    
   ```
   -  remote_user
        User name with which to login to the remote server, normally set by
        the remote_user keyword.
        If no user is supplied, Ansible will let the SSH client binary
        choose the user as it normally.
   ```
