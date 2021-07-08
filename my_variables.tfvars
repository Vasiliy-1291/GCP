network_name = "vasil-simanau-vpc"
instance_name = "nginx-terraform-whith-subnets"
zone = "us-central1-a"
machine_type = "custom-1-4608"
image = "centos-7-v20210701"
labels = {
    "server_type" = "nginx_server"
    "os_family" = "redhat"
    "way_of_installation" = "terraform"
}
description = "Nginx server created by Terraform"
disk_size = "35"
disk_type = "pd-ssd"
my_skript = "sudo yum install epel-release -y; sudo yum install nginx -y; sudo systemctl start nginx; sudo systemctl enable nginx; sudo su; echo 'Hello from Vasil Simanau' > /usr/share/doc/HTML/index.html"
