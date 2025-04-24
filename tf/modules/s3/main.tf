#module "s3_bucket" {
#  source      = "./modules/s3"
#  bucket_name = "my-s31111111333"
#  region      = var.region
#  token       = var.token
#}
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
resource "yandex_iam_service_account" "s3_user" {
  name        = "s3-access-sa"
  description = "Service account for S3 access"
}
resource "yandex_resourcemanager_folder_iam_binding" "s3_admin" {
  folder_id = var.folder_id
  role      = "storage.admin" # Or "storage.uploader", "storage.viewer"
  members = [
    "serviceAccount:${yandex_iam_service_account.s3_user.id}"
  ]
}
# Creating static access keys (like AWS IAM)
resource "yandex_iam_service_account_static_access_key" "s3_keys" {
  service_account_id = yandex_iam_service_account.s3_user.id
  description        = "Static access key for S3"
}

