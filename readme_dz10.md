# Sergey Sokolov
1. 
``` HTTP/1.1 301 Moved Permanently  
cache-control: no-cache, no-store, must-revalidate  
location: https://stackoverflow.com/questions  
x-request-guid: 690929e2-e415-4e49-89a4-754539090eae  git hob
feature-policy: microphone 'none'; speaker 'none'
content-security-policy: upgrade-insecure-requests; frame-ancestors 'self' https://stackexchange.com
Accept-Ranges: bytes
Date: Thu, 17 Feb 2022 12:33:45 GMT
Via: 1.1 varnish
Connection: close
X-Served-By: cache-hhn4026-HHN
X-Cache: MISS
X-Cache-Hits: 0
X-Timer: S1645101225.952543,VS0,VE666
Vary: Fastly-SSL
X-DNS-Prefetch-Control: off
Set-Cookie: prov=3c81b1f5-8bc8-557d-377b-7bd1a42789ec; domain=.stackoverflow.com; expires=Fri, 01-Jan-2055 00:00:00 GMT; path=/; HttpOnly

Connection closed by foreign host.
```
Полученный код сообщает , что страница переехала навсегда по адресу указанному в поле location</br>
2.
 Первым поидее должны получить 307 код редиректа, но видимо это не работает в мозиле, я попробовал на 2 разных компах, там эта ошибка не отображается. Хотя в других браузерах этот запрос есть.</br>
 opera![image](https://user-images.githubusercontent.com/93119897/154495289-c65fcb1d-8c8c-4ad0-9647-5c37f5f6d13d.png) </br>
 firefox![image](https://user-images.githubusercontent.com/93119897/154496916-a73a02ea-6eb2-4df1-8db1-1fc4b420df94.png)</br>
дольше всего обрабатывалось получение данных со страницы stackoverflow.com</br>
![image](https://user-images.githubusercontent.com/93119897/154497570-b36864b8-c00b-4eae-98f8-4157bcbae023.png)</br>

3.   176.59.168.112
4.  descr:          Tele2 Russia Groups, origin: AS12958, </br>
5.  AS31500 AS15169![image](https://user-images.githubusercontent.com/93119897/154510200-6b7b8587-e9f3-4c63-9ecc-c9bd248bc1d8.png)  </br>
6. Наибольшее время задержки 131 ms на ip 172.14.232.85 </br>
 не совсем понятно почему в середине списка, у некоторых AS появилось, а AS31500 стала недоступна (по сравнению с traceroute) </br> ![image](https://user-images.githubusercontent.com/93119897/154511306-c53c4028-a7b1-44fb-8ac7-e6af657ee8a7.png)  </br>
 
7.</br>DNS сервера</br>
![image](https://user-images.githubusercontent.com/93119897/154516110-c6811e15-5289-4a61-be1c-034ed41de94a.png)</br>
А записи </br>
![image](https://user-images.githubusercontent.com/93119897/154516244-ee34bad3-9751-4f3e-a7a0-a98ac8b98976.png)</br>

8.
Доменное имя dns.google. У второго адреса тоже имя</br>
![image](https://user-images.githubusercontent.com/93119897/154517155-04dd0b03-7cb8-4060-9cda-ba5ad5a17b1b.png)



