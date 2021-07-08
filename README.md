# GCP
Laba_2021

## For create instance by Terraform:
# Run commands:
export GOOGLE_APPLICATION_CREDENTIALS=/your/pass/for/credention.yson
export GOOGLE_CLOUD_KEYFILE_JSON=/your/pass/for/credention.yson
terraform apply -var-file=my_variables.tfvars
