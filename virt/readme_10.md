### Sergey Sokolov
## Задача 1
```
version: '2.1'

services:
  es01:
    image: elasticsearch:7.16.1
    container_name: elasticsearch
    
    restart: always
    volumes:
      - ./elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml
      - ./data:/var/lib/data
      - ./logs:/var/lib/logs
    ports:
      - "9200:9200"
      - "9300:9300"
  ```
![image](https://user-images.githubusercontent.com/93119897/174083937-d9edb01a-d7a2-4eb9-a3a7-3e742f041022.png)

 ## Задача 2
 
  ![image](https://user-images.githubusercontent.com/93119897/174084155-06efd9ed-4325-467d-a1e1-c25eddf74413.png)
  ![image](https://user-images.githubusercontent.com/93119897/174084285-477517e2-b00a-40f4-901a-1775cd98fe5a.png)
  ![image](https://user-images.githubusercontent.com/93119897/174084473-076c7e3f-faed-42bd-bca4-1c4453915288.png)
  ![image](https://user-images.githubusercontent.com/93119897/174084551-6dfe2951-a25f-4106-894b-225af54925db.png)
 Желтый статус  из-за того , что мы имеем физически один сервер в кластере , а в настройках реплик и шард больше 1.
 ## Задача 3
![image](https://user-images.githubusercontent.com/93119897/174120278-52939aff-a266-46c7-ab74-3b3d153efb61.png)
![image](https://user-images.githubusercontent.com/93119897/174120334-ac83a9f7-a241-4301-a58b-e3e5754dac3c.png)
![image](https://user-images.githubusercontent.com/93119897/174120380-d7be9112-28c0-4e95-aa2c-7abfa2207746.png)
![image](https://user-images.githubusercontent.com/93119897/174120465-1925678a-bcca-47a8-91bc-d42a5dfbb311.png)




