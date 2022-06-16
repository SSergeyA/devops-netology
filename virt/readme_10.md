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

 ## Задача 3
 


