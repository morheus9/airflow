terraform {
  required_version = ">= 1.0.0"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.101.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.2.3"
    }
    random = {
      source  = "hashicorp/random"
      version = "> 3.3"
    }
  }
  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    bucket = "terraform-state-backend"
    region = "ru-central1"
    key    = "terraform.tfstate"
    # dynamodb_table = "terraform-locks"  # Если используется блокировка
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}

provider "local" {}

provider "random" {}



