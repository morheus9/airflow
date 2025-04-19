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
- Comment backend in the **versions.tf**
### Create s3 for state:
```
cd ./tf
terraform init
terraform plan
terraform apply -target=module.s3_bucket
```
- Export the credits of your service account with access to S3 bucket before launching tf:
```
export AWS_ACCESS_KEY_ID=access_key_example
export AWS_SECRET_ACCESS_KEY=secret_key_example
```
- Uncomment backend in the **versions.tf**
### Create k8s
- Migrate state to *s3* bucket and create for example *managed k8s cluster*:
```
terraform init -migrate-state
terraform plan
terraform apply -target=module.kube
terraform apply -target=module.addons
```
- Connect to cluster by connect string from *output*
- Install test nginx and check
```
cd tf/modules/kube/nginx.yaml
kubectl apply -f nginx.yaml
kubectl get ingress nginx-ingress -o jsonpath='{.status.loadBalancer.ingress[0].ip}'
```
### Create VMs
```
terraform init -migrate-state
terraform plan
terraform apply -target=module.vm
```
### Create Network
terraform init -migrate-state
terraform plan
terraform apply -target=module.network