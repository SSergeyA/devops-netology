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

 
