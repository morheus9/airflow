# Terraform modules

- [Yandex Object Storage](https://yandex.cloud/ru/docs/storage)
- [Yandex Managed Service for Kubernetes](https://yandex.cloud/ru/docs/managed-kubernetes)
- [Setup terraform](https://yandex.cloud/ru/docs/tutorials/infrastructure-management/terraform-quickstart)
- [Setup terraform backend](https://yandex.cloud/ru/docs/tutorials/infrastructure-management/terraform-state-storage)
- [K8s from terraform](https://yandex.cloud/ru/docs/managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create)

1. Install yc cli:
```
curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
```
2. Log in via the Yandex Cloud console under the required service account:
```
yc init
```
3. Check the variables of modules
4. Install Terraform
```
sudo snap install terraform --classic
```
5. Set up a teraform by specifying a provider:
```
sudo nano ~/.terraformrc
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
7. Comment backend in the **versions.tf**
8. Create s3 for state:
```
cd ./infra/terraform
terraform init -backend=false 
terraform plan -target=module.s3_bucket -backend=false 
terraform apply -target=module.s3_bucket
```
9. Export the credits of your service account with access to S3 bucket before launching tf:
```
export AWS_ACCESS_KEY_ID=access_key_example
export AWS_SECRET_ACCESS_KEY=secret_key_example
```
10. Uncomment backend in the **versions.tf**
11. Migrate state to s3 bucket and create managed k8s cluster:
```
terraform init -migrate-state
terraform plan
terraform apply
```