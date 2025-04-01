resource "yandex_storage_bucket" "bucket" {
  bucket     = var.bucket_name
  max_size   = 1073741824  # 1 ГБ в байтах
  folder_id  = var.folder_id
  acl        = "private"   # Приватный доступ

  # Версионирование (чтобы откатывать состояние)
  versioning {
    enabled = true
  }

  # Шифрование данных
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

# Защита от случайного удаления
#  lifecycle {
#    prevent_destroy = true
#  }
}