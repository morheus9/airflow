output "s3_bucket_id" {
  description = "The ID of the S3 bucket"
  value       = module.s3_bucket.bucket_id
}

output "s3_bucket_name" {
  description = "The name of the S3 bucket"
  value       = module.s3_bucket.bucket_name
}

output "s3_bucket_url" {
  description = "The URL of the S3 bucket"
  value       = module.s3_bucket.bucket_url
}
