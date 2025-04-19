This Terraform module is designed for deploying virtual machines.
The module supports the following parameters:
```
variable "zone" {
  type    = string
  default = "ru-central1-a"
}

variable "platform_id" {
  type    = string
  default = "standard-v3"
}

variable "image_id" {
  type    = string
  default = "fd85m9q2qspfnsv055rh"
}

variable "disk_size" {
  type    = number
  default = 20
}

variable "username" {
  type    = string
  default = "ubuntu"
}

variable "vm_name" {
  type    = string
  default = "test-vm"
}

variable "ssh_public_key" {
  type    = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDUeRnCmJ3zYSOneL5WXs5EEMC94JIDXMRob9vtgKWwqjA4D5aML0NeLbXnBQ4TwU9PVF4ypqIlu+bEDSYuuflh5l2TgVixJWQ669spVQiL6ad0zYmN1HeSViRcIYhpi7yBr2jB+/B0HoDXVEVbd6GmdujLk6rM2xadSENHTC0hYxncaZttiRY5V4dt3DPasJCGEBa0ltYaJWb/VwzITvU1qssPeezZg+4iEp/JrdjJ2USkaeJWs9VrR+TLh3RGN2hzh9Qd95yuNrYbijaSFuOFrdbZCBPOYwmISUSbstcqpjEZb4qxu2y+fSh8c0JNYsaCn5PfbIwqhS8ZiFIOfWhnhgWBl62PAd9aqQFq7DLEE8aD+RArwijhkSc1Y4OYmdk8vo2RGgSJU8C0uAoxEjsQOQnJ3plYLjm/6hGoVDkMD5hYqfQrICEd6CF9+/rLge/yHPz+xQvqxRxT55HdTAyRbkKGaQw9KECMNBh4mi2zPhfiHygFCgMiXeFd2YlvZQk= your_email@example.com"
}

variable "scheduling_policy" {
  description = "Instance scheduling policy configuration"
  type = object({
    preemptible = bool
  })
  default = {
    preemptible = false
  }
}
```
After execution, the module outputs:
```
output "vm_ip" {
  value = module.instance.vm_ip_address
}
```
Example of using the module:
```
module "instance" {
  zone        = var.zone
  username    = "ansible"
  vm_name     = "test-2"
  source      = "./modules/instance"
  platform_id = "standard-v3"
  disk_size   = var.disk_size
  scheduling_policy = {
    preemptible = true # interruptible vm
  }
}
```