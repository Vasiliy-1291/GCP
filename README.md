# GCP
Laba_2021

## For create instance by Google SDK run command:

gcloud compute instances create sdk-vm-vsimanau --zone=europe-central2-a --machine-type=e2-standard-2 --boot-disk-size=10 --boot-disk-device-name=Debian

## For create instance by Terraform:

1) Run commands:
export GOOGLE_APPLICATION_CREDENTIALS=/your/pass/for/credention.yson
export GOOGLE_CLOUD_KEYFILE_JSON=/your/pass/for/credention.yson

2) Run terraform apply