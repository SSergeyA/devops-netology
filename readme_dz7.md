# Sergey Sokolov
1. chdir системный вызов, после его успешного выполнения передается значение 0![image](https://user-images.githubusercontent.com/93119897/150681784-2c2c7cd9-3d53-42d6-abbf-eb367ecc7781.png) </br>
2. по информации из man file : The information identifying these files is read from /etc/magic and
     the compiled magic file /usr/share/misc/magic.mgc, or the files in the directory /usr/share/misc/magic if the compiled file
     does not exist.  In addition, if $HOME/.magic.mgc or $HOME/.magic exists, it will be used in preference to the system magic
     files. исходя из этой информации на ходим openat(AT_FDCWD, "/etc/magic", O_RDONLY) = 3 и  openat(AT_FDCWD, "/usr/share/misc/magic.mgc", O_RDONLY) = 3
     ![image](https://user-images.githubusercontent.com/93119897/150684455-b50731bf-4a21-4a96-8bd6-dd90411c4f24.png) </br>
3. Запустил в скрине ping  сайта в файл, далее в основном терминале удаляю этот файл. командой `lsof | grep deleted`  нахожу pid процесса использующего удаленный файл, `ls  -l -h /proc/1936/fd/`
определяем дескриптор удаленного файла. Далее пришлось переключится на супер пользователя, так  не хватало прав.Далее возможно несколько вариантов обнуления содержимого дескриптора `> /proc/1936/fd/1` 
`:> /proc/1936/fd/1` `cat/dev/null> /proc/1936/fd/1` `echo ""> /proc/1936/fd/1` `truncate -s 0 /proc/1936/fd/1` . Во всех случаях содержимое файла очищается, я смотрел через cat. Но размер не скидывается.  Как я понял , из-за того , что файл открыт только на чтение. </br>
4. Зомби не потребляют никаких ресурсов, память и файловые дескрипторы таких процессов уже освобождены. Остается только запись в таблице процессов, которая занимает несколько десятков байт памяти. Так что единичный зомби процесс на систему никак не влияет. Если процессов будет очень много , они могут помешать запускатть новые, но как я понял это проблема в основном для 32 систем  </br>
5. 
  ![image](https://user-images.githubusercontent.com/93119897/150692803-07136cee-13ec-4475-83d9-3cb5822d4647.png) </br>
6.  Системный вызов uname `uname({sysname="Linux", nodename="vagrant", release="5.4.0-80-generic", version="#90-Ubuntu SMP Fri Jul 9 22:49:44 UTC 2021", machine="x86_64", domainname="(none)"}) = 0` </br>

man 2 uname `Part of the utsname information is also accessible  via  /proc/sys/kernel/{ostype, hostname, osrelease, version, domainname}.`</br>
7. Оператор `;`выполняет несколько команд одновременно последовательно, и обеспечивает вывод без зависимости от успеха и отказа других команд.</br> 
8. Оператор `&&` выполнит вторую команду только в том случае, если команда 1 успешно выполнена .


2. `grep <some_string> <some_file> | wc -l `греп находит искомые строки в указанном файле и передает их `wc`, который подсчитывает. альтернатива `grep <some_string> <some_file> -с` </br>
3. systemd(1) </br>
4.  Вывод ошибок ls (несуществующий файл) в другую сессию терминала (мы работаем в терминале 0 выводим в 1):` ls 123 2>/dev/pts/1` </
