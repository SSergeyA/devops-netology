# Sergey Sokolov
## Домашнее задание к занятию "10.01. Зачем и что нужно мониторить" 
### Обязательные задания 

  #### 1.  Вас пригласили настроить мониторинг на проект. На онбординге вам рассказали, что проект представляет из себя платформу для вычислений с выдачей текстовых отчетов, которые сохраняются на диск. Взаимодействие с платформой осуществляется по протоколу http. Также вам отметили, что вычисления загружают ЦПУ. Какой минимальный набор метрик вы выведите в мониторинг и почему?

В условии задания нам обозначены 3 критически важные точки платформы - диски, ЦПУ , доступность по http ,соответственно мониторить нужно их показатели.  
По дискам- полагаю нужно наблюдать за временем чтения/записи, длинной очереди на чтение/запись, и доступным местом. Первые два показателя покажут когда у нас начнутся проблемы с производительностью, третий позволит предотвратить отказ из-за нехватки места.  
ЦПУ - наблюдал бы за параметрами общей загруженности процессора, загруженности на работу в привилигерованном и пользовательском режимах в отдельности. это позволит анализировать, общую загрузку и превышение по отдельным процессам, если такое начнется.  
Доступность сервиса по сети - тут бы наблюдал основные метрики вебсервера, доступность по http из вне, количество успешных открытий и не успешных страницы в единицу времени. (200 и 400)


 #### 2.  Менеджер продукта посмотрев на ваши метрики сказал, что ему непонятно что такое RAM/inodes/CPUla. Также он сказал, что хочет понимать, насколько мы выполняем свои обязанности перед клиентами и какое качество обслуживания. Что вы можете ему предложить?  
    
Поясняем, что:  
RAM - загруженность оперативной памяти   
inodes - количество индексных дескрипторов, если они кончатся. нельзя будет создать файл на диске  
CPUla - это загрузка CPU в единицу времени  
Для понимания выполнения обязанностей, можно редложить мониторинг доступности сервиса из вне и процент успешных запросов к нему.

  #### 3.  Вашей DevOps команде в этом году не выделили финансирование на построение системы сбора логов. Разработчики в свою очередь хотят видеть все ошибки, которые выдают их приложения. Какое решение вы можете предпринять в этой ситуации, чтобы разработчики получали ошибки приложения?  
Первый вариант - выложить  куда то им логи и пусть сами обрабатывают.  
Второй вариант - выкладывать в облачные решения для нанализа логов, например SumoLogic , но тут надо смотреть подойдет ли конктетное решения по ограничениям. 
  
  #### 4.  Вы, как опытный SRE, сделали мониторинг, куда вывели отображения выполнения SLA=99% по http кодам ответов. Вычисляете этот параметр по следующей формуле: summ_2xx_requests/summ_all_requests. Данный параметр не поднимается выше 70%, но при этом в вашей системе нет кодов ответа 5xx и 4xx. Где у вас ошибка?  

Надо смотреть каки е коды входят в параметр summ_all_requests. Предпологаю, что там еще 100-е и 300-е коды, они не ошибки , но их наличие портит SLA
