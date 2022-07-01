provider "yandex" {
  cloud_id  = "b1gjbkb$"
  folder_id = "b1guimbreg"
  zone      = "ru-central1-a"
}

resource "yandex_storage_bucket" "netology" {
  access_key = "YCAVds6jg7"
  secret_key = "YCPztfM8FFo_3wmj"
  bucket = "netology-bucket-test"
}
