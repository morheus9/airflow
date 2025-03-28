resource "yandex_storage_bucket" "bucket" {
  bucket = var.bucket_name
  # Установка максимального размера объекта в 1 ГБ
  max_size  = 1073741824 # 1 ГБ в байтах
  folder_id = var.folder_id
}

