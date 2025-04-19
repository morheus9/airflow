resource "yandex_vpc_network" "network" {
  name = "my-network-${var.zone}"
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "my-subnet-${var.zone}"
  zone           = var.zone
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}
