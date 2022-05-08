I test it with :
Terraform v1.1.2
provider helm v2.5.1
provider hashicorp/kubernetes v2.11.0

- Change adminPassword in values.yaml
- for auto load prometheus:
```
prometheus svc name: prometheus-k8s
prometheus namespace: monitoring
```
or change address datasources.datasources.url in values.yaml

- Run Terraform commands
```
terraform init
terraform plan
terraform apply
```

