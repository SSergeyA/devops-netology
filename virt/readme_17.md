## SergeySokolov
### Задание 1
1. Найдите, где перечислены все доступные resource и data_source, приложите ссылку на эти строки в коде на гитхабе.</br>
Склонировал репозиторий и нашел в нем файл
![image](https://user-images.githubusercontent.com/93119897/181468281-9cac6012-5ce1-44a9-a808-51a2735c582e.png)
[resource](https://github.com/hashicorp/terraform-provider-aws/blob/90da50c4b6c3789b5d11afaa8b0790b14c7ad108/internal/provider/provider.go#L913)
[data_source](https://github.com/hashicorp/terraform-provider-aws/blob/90da50c4b6c3789b5d11afaa8b0790b14c7ad108/internal/provider/provider.go#L415)

2. Для создания очереди сообщений SQS используется ресурс aws_sqs_queue у которого есть параметр name.</br>

   - С каким другим параметром конфликтует name? Приложите строчку кода, в которой это указано.</br>
   name_prefix</br>
   [name](https://github.com/hashicorp/terraform-provider-aws/blob/90da50c4b6c3789b5d11afaa8b0790b14c7ad108/internal/service/sqs/queue.go#L82)
   ```
   "name": {
			Type:          schema.TypeString,
			Optional:      true,
			Computed:      true,
			ForceNew:      true,
			ConflictsWith: []string{"name_prefix"},
		},
   ```
   - Какая максимальная длина имени?</br>
   80 </br>
   https://github.com/hashicorp/terraform-provider-aws/blob/main/website/docs/r/sqs_queue.html.markdown
   ```
   name - (Optional) The name of the queue. Queue names must be made up of only uppercase and 
   lowercase ASCII letters, numbers, underscores, and hyphens, and must be between 1 and 80 
   characters long.    For a FIFO (first-in-first-out) queue,   the name must end with the 
   .fifo suffix.    If omitted, Terraform will assign a random, unique name. 
   Conflicts with name_prefix`
   ```
   https://github.com/hashicorp/terraform-provider-aws/blob/90da50c4b6c3789b5d11afaa8b0790b14c7ad108/internal/service/sqs/queue.go#L427
   
   - Какому регулярному выражению должно подчиняться имя?</br>
   (`^[a-zA-Z0-9_-]{1,80}$`) ,  как я понимаю может содержать буквы обоих регистров, цифры, подчеркивания и дефисы
   -
