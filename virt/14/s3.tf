terraform {
  backend "s3" {
     endpoint = "storage.yandexcloud.net" 
     bucket = "netology-bucket-test"
     region = "ru-central1-a"
     key = "terraform.tfstate"
     access_key = "YCA6jg7"
     secret_key = "YCPwmj"
  
     skip_region_validation = true
     skip_credentials_validation = true
     }  
}
