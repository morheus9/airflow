Данный модуль Terraform предназначен для развертывания виртуальных машин. 

Для корректной работы модуля необходимо установить следующие зависимости:

Terraform: 
```
>= v1.9.4.
```
Провайдер: 
```
yandex-cloud/yandex
required_version = ">= 0.13"
```
Модуль поддерживает следующие параметры:
```
zone
  description = "Instance availability zone"
  type        = string
  default     = "ru-central1-a"

username
  description = "The username to create on the VM"
  type        = string
  default     = "ansible"

platform_id
  description = "Platform ID for the Yandex Compute Instance"
  type        = string

scheduling_policy
  description = "Scheduling policy for the Yandex Compute Instance"
  type        = string

disk_size
  description = "Size of the boot disk in GB"
  type        = number
```

После выполнения модуль выводит:
```
vm_name - Имя создаваемой машины
zone - Зона сети
subnet_id - id Создваваемой сети
external_ip - Внешний IP адрес
created_user - Созданный пользователь
```

Пример использования модуля:
```
module "tf-yc-instance" {
  username          = var.username
  source            = "./modules/tf-yc-instance"
  zone              = var.zone
  platform_id       = var.platform_id  # Ensure this is included
  disk_size         = var.disk_size     # Ensure this is included
  scheduling_policy = var.scheduling_policy  # Ensure this is included
}
```