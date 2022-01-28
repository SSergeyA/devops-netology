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
