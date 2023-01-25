# Sergey Sokolov
## Домашнее задание к занятию "14.5 SecurityContext, NetworkPolicies"
### Задача 1: Рассмотрите пример 14.5/example-security-context.yml

Создайте модуль

kubectl apply -f 14.5/example-security-context.yml

Проверьте установленные настройки внутри контейнера

kubectl logs security-context-demo
uid=1000 gid=3000 groups=3000  

![image](https://user-images.githubusercontent.com/93119897/214695028-a33d66f6-7ffc-4c17-a58b-bb70dc096844.png)

### Задача 2 (*): Рассмотрите пример 14.5/example-network-policy.yml

Создайте два модуля. Для первого модуля разрешите доступ к внешнему миру и ко второму контейнеру. Для второго модуля разрешите связь только с первым контейнером. Проверьте корректность настроек.  
Создал 2 пода: тест1 и тест2.  

![image](https://user-images.githubusercontent.com/93119897/214695096-2cc238da-0dc0-44b5-9a81-83f424bfe116.png)
Проверил (пропинговал адрес снаружи и адрес тест 1)    

![image](https://user-images.githubusercontent.com/93119897/214695354-ea4fa872-70ff-4f29-9a15-25c93d922f8a.png)


Для второго модуля создал ограничительную политику. Поначалу политика не сработала, так как не использовал плагин calico, пришлось перезапустить
миникуб, из-за этого сменились айпишники подов. Смена плагина не помогла, не стартовала calico-node. Пршлось удалить calico версии 3.20 и скачать 3.23  

![image](https://user-images.githubusercontent.com/93119897/214695818-f4a3b8a5-2840-4ee8-83e9-a7a83af4408f.png)
![image](https://user-images.githubusercontent.com/93119897/214695968-457bd3fe-b8b3-446b-bfe8-193674fb8b98.png)

Проверил, что под тест2 перестал пинговать гугл.ком, но продолжает пинговать тест1.  

![image](https://user-images.githubusercontent.com/93119897/214696567-cf194bd7-3539-47fe-b25b-6a1af1f90488.png)

![image](https://user-images.githubusercontent.com/93119897/214696072-455340c8-d312-4a56-be7f-628dc170af0b.png)
