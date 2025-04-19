module "s3_bucket" {
  source      = "./modules/s3"
  bucket_name = var.bucket_name
  region      = var.region
  token       = var.token
}

//module "k8s" {
//  source = "./modules/k8s"
//}
