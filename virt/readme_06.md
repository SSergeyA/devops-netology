### Sergey Sokolov
## Задача1
- Электронные чеки в json виде - необходимо использовать документо-ориентированную БД, например MongoDB . Связей у чеков не много, особо сложного поиска по ним делать не нужно 
- Склады и автомобильные дороги для логистической компании - в этом случае подойдет графовая субд, например Neo4j. Узлами будут склады , а связями дороги , по которым можно ехать
- Генеалогические деревья - тут думаю больше всего подойдет сетевая БД, но я примеров живых СУБД такого типа не нашел, поэтому можно использовать графовую, где узлами будут люди, 
- Кэш идентификаторов клиентов с ограниченным временем жизни для движка аутенфикации - подойдет база "ключ-значение", где определённому ключу, будет соответствовать идентификатор клиента, например Redis
- Отношения клиент-покупка для интернет-магазина тут подойдет Column-oriented база,  например Apache Cassandra. клиент и все его данные и покупки запишутся в строку, и потом при анализе данных по каким то параметрам,
 можно будет быстро выполнять запросы по столбцам с данными.
 
## Задача2 

- Данные записываются на все узлы с задержкой до часа (асинхронная запись) получается PА система по CAP-теореме, т.к. данные записываются в разные узлы, 
и данные доступны, но могут отличаться т.к. запись происходит в течении времени (похоже на обновление ДНС записей).
По теореме PACELC  -   PA/EC 
- При сетевых сбоях, система может разделиться на 2 раздельных кластера - раз система делится о и данные доступны PA (два раздельных кластера я понял, как отсутствие 
консистентности между узлами). По теореме PACELC  -   PA/EL
- Система может не прислать корректный ответ или сбросить соединение - это указывает на недоступность данных, т.е нет Availability - PC система.
По теореме PACELC  -   PС/EC

## Задача3

В рамках одной системы принципы ACID и Base могут сочетаться, при понимании поставленных задач. Например заказы в интернет магазине при распродаже, тут строится оформление 
заказа на Base принципах, т.к. важна скорость и доступность,  а уже его оплата и формирование на ACID. 

## Задача4
Radis 
Минусы : 
- используется для работы оперативная память
- в случае сбоя все что было в памяти будет утеряно. 
- как я понял , не от обратной связи от подписчика издателю, что сообщение прочитано
