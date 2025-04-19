output "bucket_id" {
  description = "The ID of the S3 bucket"
  value       = yandex_storage_bucket.bucket.id
}

output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = yandex_storage_bucket.bucket.bucket
}

output "bucket_url" {
  description = "The URL of the S3 bucket"
  value       = "https://${yandex_storage_bucket.bucket.bucket}.storage.yandexcloud.net/"
}
