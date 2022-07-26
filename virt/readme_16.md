### Sergey Sokolov
## Задание 1
![image](https://user-images.githubusercontent.com/93119897/181041592-e35ca41f-181b-4cfb-b7e5-465a26b46c64.png)

## Залание 2
![image](https://user-images.githubusercontent.com/93119897/181041646-b8700ee6-2139-42d1-a30f-c3196bbbb23a.png)

## Задание 3
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

