resource "yandex_storage_bucket" "bucket" {
  bucket    = var.bucket_name
  max_size  = 1073741824 # 1 GB in bytes
  folder_id = var.folder_id
  acl       = "private" # Private access

  # Versioning (to roll back the state)
  versioning {
    enabled = true
  }

  # Protection against accidental deletion
  #  lifecycle {
  #    prevent_destroy = true
  #  }
}
