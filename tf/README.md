Для использования надо добавить переменные в систему:

Переменная для терраформа из снапа
```
export PATH="/snap/bin:$PATH"
```
Переменные для подключения к AWS и облаку:
```
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
export TF_VAR_cloud_id=
export TF_VAR_folder_id=
export TF_VAR_token=
```
Переопределить, например, зону:
```
terraform plan -var="zone=ru-central1-a"
```
Использовать переменные сегмента:
```
# terraform apply -var-file="testing.tfvars"
```
Удалить инфру
```
# terraform destroy -var-file="testing.tfvars"
```
Подключение к VM
```
# ssh $(terraform output -raw user)@$(terraform output -raw external_ip) -i ~/.ssh/tf-cloud-init
```