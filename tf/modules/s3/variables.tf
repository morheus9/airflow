variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "terraform-state-backend"
}

variable "region" {
  description = "Region for the S3 bucket"
  type        = string
  default     = "ru-central1"
}

variable "token" {
  description = "Yandex Cloud OAuth api token"
  type        = string
}

variable "folder_id" {
  description = "Yandex Cloud Folder ID"
  type        = string
  default     = "b1gkqc24edk0v8d2gcdv"
}

variable "cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}
