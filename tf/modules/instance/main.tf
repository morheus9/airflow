module "network" {
  source = "../network"
  zone   = var.zone
}

resource "yandex_compute_instance" "vm-1" {
  name        = var.vm_name
  zone        = module.network.zone # Используем output из модуля
  platform_id = var.platform_id

  scheduling_policy {
    preemptible = var.scheduling_policy.preemptible
  }
  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = var.disk_size
    }
  }

  network_interface {
    subnet_id = module.network.subnet_id # Используем output из модуля
    nat       = true                     # Для доступа из интернета
  }

  metadata = {
    user-data = <<-EOF
      #cloud-config
      users:
        - name: ${var.username}
          groups: sudo
          shell: /bin/bash
          sudo: ['ALL=(ALL) NOPASSWD:ALL']
          ssh_authorized_keys:
            - ${var.ssh_public_key}
      EOF
  }
}
