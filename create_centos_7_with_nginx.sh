#! /bin/bash
gcloud compute --project=gcp-lab-1-vsimanau instances create nginx-gcoud-sdk \
--description="Nginx server created by Gcloud SDK" \
--zone=us-central1-c --machine-type=custom-1-4608 \
--subnet=default --network-tier=PREMIUM \
--metadata=startup-script=\#\!\ /bin/bash$'\n'sudo\ yum\ install\ epel-release\ -y$'\n'sudo\ yum\ install\ nginx\ -y$'\n'sudo\ systemctl\ start\ nginx$'\n'sudo\ systemctl\ enable\ nginx \
--maintenance-policy=MIGRATE --service-account=855374297003-compute@developer.gserviceaccount.com \
--scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
--tags=http-server,https-server --image=centos-7-v20210701 --image-project=centos-cloud \
--boot-disk-size=35GB --boot-disk-type=pd-ssd --boot-disk-device-name=nginx-gcoud-sdk \
--no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring \
--labels=server_type=nginx_server,os_family=redhat,way_of_installation=gcloud_sdk \
--reservation-affinity=any