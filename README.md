# Terraform helm grafana configuration

<p align="center" style="text-align:center;">
  <a href="https://grafana.com/">
    <img alt="grafana logo" src="img/grafana.jpeg" width="500" />
  </a>
</p>


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

if you want to recreate a machine without destroy and recreate whole the infrastracture, you can go for the taint command 

`terraform taint [options] <address>`

and new Recommand for Terraform v0.15.2 and later is -replace flag 

`terraform apply -replace="aws_instance.example[0]"`
