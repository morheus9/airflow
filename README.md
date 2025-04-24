## Terraform modules

- [Yandex Object Storage](https://yandex.cloud/ru/docs/storage)
- [Yandex Managed Service for Kubernetes](https://yandex.cloud/ru/docs/managed-kubernetes)
- [Setup terraform](https://yandex.cloud/ru/docs/tutorials/infrastructure-management/terraform-quickstart)
- [Setup terraform backend](https://yandex.cloud/ru/docs/tutorials/infrastructure-management/terraform-state-storage)
- [K8s from terraform](https://yandex.cloud/ru/docs/managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create)

1. Install **yc** cli:
```
curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
```
2. Get *OAuth* token and log in via the Yandex Cloud console under the required service account:
```
yc init
```
3. Check the variables of modules
4. Install Terraform
```
snap install terraform --classic
```
5. Set up a teraform by specifying a provider:
```
nano ~/.terraformrc
```
```
provider_installation {
  network_mirror {
    url = "https://terraform-mirror.yandexcloud.net/"
    include = ["registry.terraform.io/*/*"]
  }
  direct {
    exclude = ["registry.terraform.io/*/*"]
  }
}
```
6. Export envs:
```
export TF_VAR_cloud_id=$(yc config get cloud-id)
export TF_VAR_folder_id=$(yc config get folder-id)
export TF_VAR_token=$(yc iam create-token)
```
7. Create s3 for state backend
```
cd ./tf/modules/s3
terraform init
terraform plan
terraform apply
```
8. Export the credentials of your service account with access to S3 bucket:
```
export AWS_ACCESS_KEY_ID=$(terraform output -raw aws_access_key_id)
export AWS_SECRET_ACCESS_KEY=$(terraform output -raw aws_secret_access_key)
```
9. Change backend and create other modules
```
cd ../..
terraform init -reconfigure
terraform apply
```
10. Connect to cluster by connect string from *output*
```
$(terraform output -raw internal_cluster_cmd_str)
```
11. Install test nginx and check
```
cd tf/modules/kube/nginx.yaml
kubectl apply -f nginx.yaml
kubectl get ingress nginx-ingress -o jsonpath='{.status.loadBalancer.ingress[0].ip}'
```