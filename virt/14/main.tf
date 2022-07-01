provider "yandex" {
  cloud_id  = "b1gd88frf016p6u7jbkb$"
  folder_id = "b1gump4iofj1llimbreg"
  zone      = "ru-central1-a"
}

resource "yandex_storage_bucket" "netology" {
  access_key = "YCAJEYylkEeiCNPPOGVds6jg7"
  secret_key = "YCPztfMcUf_YhzCgQ7Tm9JQ____qSd58FFo_3wmj"
  bucket = "netology-bucket-test"
}
