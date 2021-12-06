# devops-netology
игнорируются все файлы в  скрытых дирректориях с названием терраформ <br>
**/.terraform/* <br>
игнорируются любые файлы с расширением (или есть в расширении) tfsatate  <br>
*.tfstate <br>
*.tfstate.* <br>
игнорируются файлы crash.log <br>
crash.log <br>
игнорируются все файлы с расширением tfvars <br>
*.tfvars  <br>
игнорируются файлы override.tf <br>
override.tf <br>
игнорируются файлы override.tf.json <br>
override.tf.json  <br>
игнорируются файлы  в которых имя  заканчивается на _override и расширение tf <br>
*_override.tf <br>
игнорируются файлы  в которых имя  заканчивается на _override и расширение tf.json <br>
*_override.tf.json <br>
но можно включить отслеживение файлов !example_override.tf , несмотря на правило выше <br>
#!example_override.tf <br>
исключит где в названии есть *tfplan* <br>
*tfplan* <br>
игнорируются скрытые файлы terraformrc <br>
.terraformrc <br>
игнорируются файлы terraform.rc<br>
terraform.rc <br>
