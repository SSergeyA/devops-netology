# Sergey Sokolov
1. Список интерфейсов можно посмотреть ` ifconfig` или `ip -br link show`</br>
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
file:///home/sergey/Pictures/Screenshot%20from%202022-02-18%2016-39-58.png![image](https://user-images.githubusercontent.com/93119897/154693992-1a84bdc9-5e5f-4961-baad-fbfb06757835.png)
