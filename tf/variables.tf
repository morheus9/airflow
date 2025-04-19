variable "token" {
  description = "Yandex Cloud OAuth api token"
  type        = string
}

variable "cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Yandex Cloud Folder ID"
  type        = string
}

variable "zone" {
  description = "Yandex Cloud Zone"
  type        = string
  default     = "ru-central1-a"
}

variable "region" {
  description = "Region for the S3 bucket"
  type        = string
  default     = "ru-central1"
}

# s3

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "my-s31111"
}

# Instanse

variable "username" {
  description = "The username to create on the VM"
  type        = string
  default     = "ansible"
}

variable "platform_id" {
  description = "Platform ID for the Yandex Compute Instance"
  type        = string
  default     = "fd84b1mojb8650b9luqd"
}

variable "scheduling_policy" {
  description = "Scheduling policy for instances"
  type = object({
    preemptible = bool
  })
  default = {
    preemptible = false
  }
}
variable "disk_size" {
  description = "Size of the boot disk in GB"
  type        = number
  default     = 40
}

variable "vm_name" {
  type    = string
  default = "test-vm"
}
