# Kubernetes Master node common parameters
variable "public_access" {
  description = "Public or private Kubernetes cluster"
  type        = bool
  default     = true
}

variable "folder_id" {
  description = "Yandex Cloud Folder ID"
  type        = string
  default     = "b1gkqc24edk0v8d2gcdv"
}
