## Sokolov Sergey

### Задача 1

   - Какой тип инфраструктуры будем использовать для этого проекта: изменяемый или не изменяемый? </br>
   
     Думаю, что будет изменяемый тип инфраструктуры, поскольку это вне внешний сервис для заказчика 
     и четкого тз нет и будут доработки. Хотя тут надо уточнить, а сколько важна безопасность и отказоустойчивость этого сервиса,
     возможно его имеет смысл потом сделать неизменяемым, или делать изначально , если этот сервис связан с безопасностью или финансами, 
     где стабильность приоритенее. </br>
     
   - Будет ли центральный сервер для управления инфраструктурой?</br>
   
     Думаю нет. Надо понимать задачу насколько он нужен, проще делать инфраструктуру без центрального сервера.</br>
     
   - Будут ли агенты на серверах?</br>
     
     Нет, они не обязательны.  
   
   - Будут ли использованы средства для управления конфигурацией или инициализации ресурсов?</br>
   
     Да, поскольку будут частые изменения

   - Какие инструменты из уже используемых вы хотели бы использовать для нового проекта?</br>
     Terraform + Packer + Docker + Kubernetes
   - Хотите ли рассмотреть возможность внедрения новых инструментов для этого проекта?</br>
     Если в новых инструментах есть необходимость или они лучше по функционалу . чем использующиеся то да.
 
### Задача 2

![image](https://user-images.githubusercontent.com/93119897/175525534-67f036d5-9177-4ba9-9d6a-1efa539a41f8.png)

### Задача 3
![image](https://user-images.githubusercontent.com/93119897/175525630-02bdb663-0930-485a-9544-87f871ce9b8f.png)