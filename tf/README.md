Variables for AWS and cloud:
```
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
export TF_VAR_cloud_id=
export TF_VAR_folder_id=
export TF_VAR_token=
```
Redefine, for example, the zone:
```
terraform plan -var="zone=ru-central1-a"
```
Use segment variables:
```
terraform apply -var-file="testing.tfvars"
```
Delete infra:
```
terraform destroy -var-file="testing.tfvars"
```
Connect to created VM
```
# ssh $(terraform output -raw user)@$(terraform output -raw external_ip) -i ~/.ssh/tf-cloud-init
```