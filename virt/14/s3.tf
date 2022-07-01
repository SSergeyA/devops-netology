terraform {
  backend "s3" {
     endpoint = "storage.yandexcloud.net" 
     bucket = "netology-bucket-test"
     region = "ru-central1-a"
     key = "terraform.tfstate"
     access_key = "YCAJEYylkEeiCNPPOGVds6jg7"
     secret_key = "YCPztfMcUf_YhzCgQ7Tm9JQ____qSd58FFo_3wmj"
  
     skip_region_validation = true
     skip_credentials_validation = true
     }  
}
