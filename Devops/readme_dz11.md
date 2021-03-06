# Sergey Sokolov
1. Список интерфейсов можно посмотреть ` ifconfig` или `ip -br link show` (в винде ipconfig)</br>
2. используется протокол LLDP . Можно утановить пакет lldpd и запустить его как службу, и выполнить команду `sudo lldpctl`</br>
3. для разделения используется технология  VLAN. в линукс есть пакет  vlan. Для старых версий убунты , ниже 17 , как я понимаю проходит вариант правки /etc/network/interfaces, по примеру ниже
 ``` auto wlp2s0.50
iface wlp2s0.50 inet static
      address 192.168.19.2
      netmask 255.255.255.0
      vlan-raw-device wlp2s0
```
Для дистрибутивов убунты выше 17 нужно настраивать сеть при помощи netplan или устанавливать пакет ifupdown. Я настраивал в  netplan
``` network:
    renderer: networkd
    version: 2
    ethernets:
        wlp2s0:
            dhcp4: yes
    vlans:
       vlan.50:
         id: 50
         link: wlp2s0
         dhcp4: no
         addresses: [192.168.19.2/24]
``` 
![image](https://user-images.githubusercontent.com/93119897/154693992-1a84bdc9-5e5f-4961-baad-fbfb06757835.png)
4. Linux поддерживает несколько режимов агрегации интерфейсов: </br>
    0 (balance-rr) — round-robin распределение пакетов между интерфейсами. Обеспечивает отказоустойчивость и повышение пропускной способности.</br>
    1 (active-backup) — в каждый момент времени работает только один интерфейс, в случае его выхода из строя, mac-адрес назначается второму интерфейсу и трафик переключается на него.</br>
    2 (balance-xor) — обеспечивает балансировку между интерфейсами на основании MAC-адресов отправителя и получателя.</br>
    3 (broadcast) — отправляет пакеты через все интерфейсы одновременно, обеспечивает отказоустойчивость.</br>
    4 (802.3ad) — обеспечивает агрегацию на основании протокола 802.3ad.</br>
    5 (balance-tlb) — в этом режиме входящий трафик приходит только на один «активный» интерфейс, исходящий же распределяется по всем интерфейсам.</br>
    6 (balance-alb) — балансирует исходящий трафик как tlb, а так же входящий IPv4 трафик используя ARP.</br>
    
Для балансировки нагрузки подойдут режимы 0,2,5 и 6. </br>
    
  
```network:
ethernets:
    enp0s31f6:
        dhcp4: no
    enp1s0:
        dhcp4: no
version: 2
bonds:
    bond0:
         interfaces: [enp0s31f6,enp1s0]
         addresses: [10.0.10.10/16]
         gateway4: 10.0.0.1
         mtu: 9000
         nameservers:
              addresses: [10.0.0.1]
         parameters:
                 mode: balance-rr
                 mii-monitor-interval: 100
```
5. 6 хостов. 8 ip адресов. </br>
 можно разделить на 32 сети: 10.10.10.0/29, 10.10.10.8/29, ......  10.10.10.248/29   </br>
6. Можно использовать алреса  зарезервированные для Carrier-Grade NAT. сеть 100.64.0.0/26</br>
7. 
`arp -a`  проверить ARP таблицу можно и в линуксе и в винде</br>
`ip neigh show ` работает в линуксе</br>

Можно удалить все записи для определённого сетевого интерфейса:`ip neigh flush dev enp0s3`</br>
Очистить таблицу полностью командой flush: `ip neigh flush`</br>
Можно удалять IP адреса по одному с помощью команды del `sudo ip neigh del dev enp0s3 192.168.0.105`</br>
`arp -d 92.168.0.105` - можно удалить один адрес</br>
