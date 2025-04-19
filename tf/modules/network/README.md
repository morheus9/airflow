Данный модуль Terraform предназначен для получения данных о подсети, для последующего их использования при создании VM. 

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
  default     = "ru-central1-b"
```

После выполнения модуль выводит:
```
yandex_vpc_subnets - Данные подсети
```

Пример использования модуля:
```
module "network" {
  source  = "./modules/network"
  zone    = var.zone
}
```