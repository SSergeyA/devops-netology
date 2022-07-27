### Sergey Sokolov
## Задание 1Установите golang.

    Воспользуйтесь инструкций с официального сайта: https://golang.org/.
    Так же для тестирования кода можно использовать песочницу: https://play.golang.org/.


![image](https://user-images.githubusercontent.com/93119897/181041592-e35ca41f-181b-4cfb-b7e5-465a26b46c64.png)

## Залание 2 Знакомство с gotour.

У Golang есть обучающая интерактивная консоль https://tour.golang.org/. Рекомендуется изучить максимальное количество примеров. В консоли уже написан необходимый код, осталось только с ним ознакомиться и поэкспериментировать как написано в инструкции в левой части экрана.
![image](https://user-images.githubusercontent.com/93119897/181041646-b8700ee6-2139-42d1-a30f-c3196bbbb23a.png)

## Задание 3 Написание кода.

Цель этого задания закрепить знания о базовом синтаксисе языка. Можно использовать редактор кода на своем компьютере, либо использовать песочницу: https://play.golang.org/.

    Напишите программу для перевода метров в футы (1 фут = 0.3048 метр). Можно запросить исходные данные у пользователя, а можно статически задать в коде. Для взаимодействия с пользователем можно использовать функцию Scanf:

    package main

    import "fmt"

    func main() {
        fmt.Print("Enter a number: ")
        var input float64
        fmt.Scanf("%f", &input)

        output := input * 2

        fmt.Println(output)    
    }

    Напишите программу, которая найдет наименьший элемент в любом заданном списке, например:

    x := []int{48,96,86,68,57,82,63,70,37,34,83,27,19,97,9,17,}

    Напишите программу, которая выводит числа от 1 до 100, которые делятся на 3. То есть (3, 6, 9, …).

В виде решения ссылку на код или сам код.

1.
```
package main

import "fmt"

func main() {
	fmt.Print("Enter a number: ")
	var input float64
	fmt.Scanf("%f", &input)

	output := input * (0.3048)

	fmt.Println(output)
}
```
![image](https://user-images.githubusercontent.com/93119897/181041418-c56e00bc-c0ab-4b93-a301-b3838a6519e2.png)

2.
```
package main
        
        import "fmt"
        
        func main() {
            x := []int{48,96,86,68,57,82,63,70,37,34,83,27,19,97,55,17,}
            min := x [0]
            fmt.Println ("x=: ", x)
            for _, value := range x {
                if (value < min){
                min = value
                    }
                
            }
            fmt.Println("min элемент : ", min)
        }    
```
![image](https://user-images.githubusercontent.com/93119897/181045375-336a093b-fc3b-41ab-b8e3-007c8a26371f.png)
3.
```
package main
        
        import "fmt"
        
        
        
           func main() { 
            for i := 1; i <=100; i++{
                    
                if (i%3) == 0 {
                    fmt.Print(i,", ")
                    }
                }
        }
```
![image](https://user-images.githubusercontent.com/93119897/181048558-ad88a321-8c57-4004-b2c7-14091986e892.png)

