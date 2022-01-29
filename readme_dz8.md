# Sergey Sokolov
1. node-exporter![image](https://user-images.githubusercontent.com/93119897/151541100-57c45a1e-469a-4027-acab-a349e5de923d.png)
 </br>
 2. По CPU </br>
node_cpu_seconds_total{cpu="0",mode="idle"} 16051.68</br>
node_cpu_seconds_total{cpu="0",mode="iowait"} 3.22</br>
node_cpu_seconds_total{cpu="0",mode="softirq"} 1.28</br>
node_cpu_seconds_total{cpu="0",mode="system"} 6.36</br>
node_cpu_seconds_total{cpu="0",mode="user"} 5.59</br>
 
 По памяти </br>
 node_memory_MemAvailable_bytes 7.5354112e+08</br>
 node_memory_MemFree_bytes 1.34193152e+08</br>

По диску</br>
node_disk_read_bytes_total{device="sda"} 6.59956736e+08</br>
node_disk_written_bytes_total{device="sda"} 3.4107904e+08</br>
node_disk_io_time_seconds_total{device="sda"} 20.256</br>
node_disk_read_time_seconds_total{device="sda"} 12.115</br>
node_disk_write_time_seconds_total{device="sda"} 15.993</br>

По сети</br>
node_network_receive_bytes_total{device="lo"} 523688</br>
node_network_speed_bytes{device="eth0"} 1.25e+08</br>
node_network_transmit_bytes_total{device="lo"} 523688</br>
node_network_transmit_errs_total{device="lo"} 0</br>

3.</br>
localhost:19999![image](https://user-images.githubusercontent.com/93119897/151656707-6d70432d-0d0f-4529-91e8-f16d462fa22e.png)</br>
4. Да </br>
![image](https://user-images.githubusercontent.com/93119897/151657660-ad3bcb8e-f511-4abf-a4b5-861764c16260.png)</br>
5. </br>
/sbin/sysctl -n fs.nr_open</br>
1048576</br>
это общесистемное ограничение максимального количества файловых дескрипторов 1024Х1024</br>
так же существуют мягкое и жесткое ограничение ограничение количества открытых дескрипторов накладываемых на пользователей для доступа к ресурсам оболочки. эти ограничения не дадут превысить максимальное ограничение</br>
vagrant@vagrant:~$ ulimit -Hn</br>
1048576</br>
vagrant@vagrant:~$ ulimit -Sn</br>
1024</br>

6. </br>
![image](https://user-images.githubusercontent.com/93119897/151662778-3608ccba-ac75-4c3f-824d-586e06b2890c.png)</br>
7. эта команда является логической бомбой. Она оперирует определением функции с именем ‘:‘, которая вызывает сама себя дважды: один раз на переднем плане и один раз в фоне. Она продолжает своё выполнение снова и снова, пока система не зависнет. этот процесс  займёт всю физическую память компьютера. и он просто не зависнет. Ни к чему фатальному это конечно не приведет, но перезагрузиться придётся.


