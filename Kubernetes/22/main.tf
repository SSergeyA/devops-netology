# задаю конфигурацию провайдера
terraform {
  required_version = ">= 1.1.0"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.13"
    }
  }
}
provider "yandex" {
  token     = var.YC_TOKEN
  cloud_id  = var.YC_CLOUD_ID
  folder_id = var.YC_FOLDER_ID
  zone      = "ru-central1-a"
}
resource "yandex_iam_service_account" "sa2" {
  name = "bucketserviceac1"
}
# Назначение роли сервисному аккаунту
resource "yandex_resourcemanager_folder_iam_member" "sa2-editor" {
  folder_id = var.YC_FOLDER_ID
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa2.id}"
}

# Создание статического ключа доступа
resource "yandex_iam_service_account_static_access_key" "sa2-static-key" {
  service_account_id = yandex_iam_service_account.sa2.id
  description        = "static access key for object storage"
}
# создание ключа шифрования
resource "yandex_kms_symmetric_key" "key-a" {
  name = "skey"
  description = "keyforbucket"
  default_algorithm = "AES_128"
  rotation_period = "8760h" // 1 год
}
# Назначение роли kms сервисному аккаунту
resource "yandex_resourcemanager_folder_iam_member" "kms" {
  folder_id = var.YC_FOLDER_ID
  role = "kms.keys.encrypterDecrypter"
  member = "serviceAccount:${yandex_iam_service_account.sa2.id}"
}
#Создание бакета с использованием ключа
resource "yandex_storage_bucket" "bucket2" {
  access_key = yandex_iam_service_account_static_access_key.sa2-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa2-static-key.secret_key
  bucket     = "sergey-17022023"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.key-a.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}
#получения значений аргументов access_key и secret_key и сохранения данных значений в файле состояния.
output "access_key" {
  value = yandex_iam_service_account_static_access_key.sa2-static-key.access_key
  
}
output "secret_key" {
  value = yandex_iam_service_account_static_access_key.sa2-static-key.secret_key
  sensitive = true
}


resource "yandex_storage_object" "object2" {
  access_key = yandex_iam_service_account_static_access_key.sa2-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa2-static-key.secret_key
  bucket     = yandex_storage_bucket.bucket2.bucket
  key        = "pic.jpg"
  source     = "oslo.jpg"
// acl        = "public-read"
}
output "url" {
  value = "https://storage.yandexcloud.net/${yandex_storage_bucket.bucket2.bucket}/${yandex_storage_object.object2.key}"
}







