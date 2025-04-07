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

variable "api_access_cidr" {
  description = "CIDR block for Kubernetes API access"
  type        = string
  default = "192.0.2.0/24"
}

variable "nodeport_access_cidr" {
  description = "CIDR block for NodePort services access"
  type        = string
  default = "203.0.113.0/24"
}