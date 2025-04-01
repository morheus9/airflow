# airflow

Create s3 for state:
```
terraform init -backend=false 
terraform apply -target=module.s3_bucket
```
Migrate state to s3 bucket and create managed k8s cluster:
```
terraform init -migrate-state
terraform apply
```