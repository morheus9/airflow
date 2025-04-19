output "zone" {
  value = module.network.zone
}

output "subnet_id" {
  value = module.network.subnet_id
}

output "vm_ip_address" {
  value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
}
