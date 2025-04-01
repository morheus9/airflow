module "s3_bucket" {
  source      = "./modules/s3"
  bucket_name = var.bucket_name
  region      = var.region
  token       = var.token
}

module "k8s" {
  source = "./modules/k8s"
}

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
