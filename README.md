# GCP
Laba_2021

# For create instance by Google SDK run command:

/bin/bash create_centos_7_with_nginx.sh
(file added to repository)

# For create instance by Terraform:

### Run commands:

1) export GOOGLE_APPLICATION_CREDENTIALS=/your/pass/for/credention.yson 
2) export GOOGLE_CLOUD_KEYFILE_JSON=/your/pass/for/credention.yson
3) terraform apply -var-file=/home/vasiliy/GCP/GCP/task_2_vars.tfvars

(files "task_2_vars.tfvars" and "centos_7_with_nginx.tf"  added to repository)

## Code for Create and attach Disk added to configuration file "centos_7_with_nginx.tf"
