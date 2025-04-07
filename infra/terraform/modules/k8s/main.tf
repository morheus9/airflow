locals {
  folder_id = var.folder_id
}

### СЕТЕВЫЕ РЕСУРСЫ ###
resource "yandex_vpc_network" "mynet" {
  name = "k8s-network"
}

resource "yandex_vpc_subnet" "mysubnet" {
  name           = "k8s-subnet"
  v4_cidr_blocks = ["10.1.0.0/24"]
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.mynet.id
}

### KMS КЛЮЧ ###
resource "yandex_kms_symmetric_key" "kms-key" {
  name              = "k8s-secrets-key"
  default_algorithm = "AES_256"
  rotation_period   = "8760h"
}

### СЕРВИСНЫЕ АККАУНТЫ ###
# Аккаунт для мастер-узла
resource "yandex_iam_service_account" "master-account" {
  name        = "k8s-master-account"
  description = "Service account for K8S cluster master"
}

# Аккаунт для рабочих узлов
resource "yandex_iam_service_account" "node-account" {
  name        = "k8s-node-account"
  description = "Service account for K8S worker nodes"
}

### IAM РОЛИ ###
# Права для мастер-аккаунта
resource "yandex_resourcemanager_folder_iam_member" "master-permissions" {
  for_each = toset([
    "k8s.clusters.agent",
    "vpc.publicAdmin",
    "kms.keys.encrypterDecrypter"
  ])
  folder_id = local.folder_id
  role      = each.key
  member    = "serviceAccount:${yandex_iam_service_account.master-account.id}"
}

# Права для node-аккаунта
resource "yandex_resourcemanager_folder_iam_member" "node-permissions" {
  for_each = toset([
    "container-registry.images.puller",
    "kms.keys.encrypterDecrypter"
  ])
  folder_id = local.folder_id
  role      = each.key
  member    = "serviceAccount:${yandex_iam_service_account.node-account.id}"
}

### КЛАСТЕР KUBERNETES ###
resource "yandex_kubernetes_cluster" "k8s-zonal" {
  name       = "k8s-zonal-cluster"
  network_id = yandex_vpc_network.mynet.id

  master {
    master_location {
      zone      = yandex_vpc_subnet.mysubnet.zone
      subnet_id = yandex_vpc_subnet.mysubnet.id
    }
    security_group_ids = [yandex_vpc_security_group.k8s-sg.id]
    public_ip          = true
  }

  service_account_id      = yandex_iam_service_account.master-account.id
  node_service_account_id = yandex_iam_service_account.node-account.id

  kms_provider {
    key_id = yandex_kms_symmetric_key.kms-key.id
  }

  depends_on = [
    yandex_resourcemanager_folder_iam_member.master-permissions,
    yandex_resourcemanager_folder_iam_member.node-permissions
  ]
}

### ГРУППА УЗЛОВ ###
resource "yandex_kubernetes_node_group" "k8s-nodes" {
  cluster_id  = yandex_kubernetes_cluster.k8s-zonal.id
  name        = "k8s-worker-nodes"
  
  instance_template {
    platform_id = "standard-v2"
    
    resources {
      memory = 4
      cores  = 2
    }

    boot_disk {
      type = "network-ssd"
      size = 64
    }

    network_interface {
      subnet_ids = [yandex_vpc_subnet.mysubnet.id]
      nat        = true # Доступ в интернет для узлов
    }
  }

  scale_policy {
    fixed_scale {
      size = 2 # Кол-во узлов
    }
  }
}

### ГРУППА БЕЗОПАСНОСТИ ###
resource "yandex_vpc_security_group" "k8s-sg" {
  name        = "k8s-security-group"
  description = "Security group for K8S cluster"
  network_id  = yandex_vpc_network.mynet.id

  # Kubernetes API
  ingress {
    protocol       = "TCP"
    description    = "K8S API Secure Port"
    v4_cidr_blocks = [var.api_access_cidr]
    port           = 6443
  }

  # Health Checks
  ingress {
    protocol          = "TCP"
    description       = "Load Balancer Health Checks"
    predefined_target = "loadbalancer_healthchecks"
    port              = 0
    to_port           = 65535
  }

  # Internal Communication
  ingress {
    protocol          = "ANY"
    description       = "Internal node communication"
    predefined_target = "self_security_group"
    from_port         = 0
    to_port           = 65535
  }

  # Restricted NodePort Access
  ingress {
    protocol       = "TCP"
    description    = "NodePort Services"
    v4_cidr_blocks = [var.nodeport_access_cidr]
    from_port      = 30000
    to_port        = 32767
  }
  
  # Outbound Traffic
  egress {
    protocol       = "ANY"
    description    = "Full outbound access"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}