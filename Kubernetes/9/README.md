# Sergey Sokolov
## Домашнее задание к занятию "12.5 Сетевые решения CNI"

После работы с Flannel появилась необходимость обеспечить безопасность для приложения. Для этого лучше всего подойдет Calico.
### Задание 1: установить в кластер CNI плагин Calico

Для проверки других сетевых решений стоит поставить отличный от Flannel плагин — например, Calico. Требования:

    установка производится через ansible/kubespray;
    после применения следует настроить политику доступа к hello-world извне. Инструкции kubernetes.io, Calico
![image](https://user-images.githubusercontent.com/93119897/203364527-3d417e25-95ef-4aab-bd54-4ee90c4e4ad2.png)
![image](https://user-images.githubusercontent.com/93119897/203364704-36ffe4df-4a6a-44c2-a071-901c4d0b39b5.png)  

Применям сначала запрещающую политику к поду и проверяем, что hello-node не доступно - значит политика сработала  
![image](https://user-images.githubusercontent.com/93119897/203365577-3940165a-6c5a-4e40-a0ed-af4c0b966c0b.png)  

Потом добавляем разрешающую политику и проверяем и с мастер ноды и из вне  
![image](https://user-images.githubusercontent.com/93119897/203366034-1ec27f2d-e766-457c-874d-163f00557f06.png)

### Задание 2: изучить, что запущено по умолчанию

Самый простой способ — проверить командой calicoctl get . Для проверки стоит получить список нод, ipPool и profile. Требования:

    установить утилиту calicoctl;
    получить 3 вышеописанных типа в консоли.
![image](https://user-images.githubusercontent.com/93119897/203366095-854e2eb8-2a7a-4f74-b0d1-2a73a22460b5.png)
