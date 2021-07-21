variable "project" {
  type = string
  default = "gcp-lab-2-vsimanau"
}

variable "nginx_name" {
    default = "nginx"
}
variable "region" {
    default = "us-central1"
}
variable "machine_type" {
    default = "n1-standard-1"
}

variable "image" {
    default = "centos-cloud/centos-7"
}

variable "nginx_disk_type" {
    default = "pd-ssd"
}
variable "my_ssh_key" {
    default = {
      ssh-keys = "vasil:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDkUTyHgRQPbgXBNxoHJccJeBUw629ju2u3q16PQZqcJzHD5A9Ygv/VfqtTMU1VK/ziUfPgBF4mjeVpYAS4PUYoiHCD4cSvxa0HVXJtr6NKGWU8y6TtT0vV3s7gg11FOVGd7JI6g6N+z3+blQ3PHNRw3R1Y1O4UA26a4RSD6B9hNZZQvCwTk/bB22nw/Rf+Jz8yJFCWSugBIGAW3DfcRGpeYnCaKEfWqkFvlosMOHGEFNNXLVx2sTCK9oriASruG6nK5nTFVQXXsPGJGwyz5VuOIGv9jW5k1swBZEOC+SS7cTxN/wMwtv10lXyfbKFgs33sMvoeEEDilx+WSD6CWsHEd0LWuM0AvCrkbv7v1HmU/YZWw9sYplqoDeb01tuTSfXpeu1X/OQJYIz50x93Fdjk7iT9TKTTmJn7i2TW3vdqaJgLd/JMvkJQM9xHEwHa5+W7nUm1jw0Wd/ClWl1KTGHT+jHlwVSi29HkHIvNffhA29A8BvH6Q8a+FTVlxpPiVUM= vasil@EPBYMINW16B1"
    }
}

variable "nginx_script" {
    default = <<SCRIPT
        sudo yum update
        sudo yum install -y nginx
        echo 'Hello from Vasil Simanau !!!' > /usr/share/nginx/html/index.html 
        sudo systemctl enable nginx
        sudo systemctl start nginx  
    SCRIPT
}

variable "tomcat_name" {
    default = "tomcat"
}

variable "tomcat_script" {
    default = <<SCRIPT
        sudo yum install tomcat -y
        sudo yum install -y tomcat-webapps tomcat-admin-webapps tomcat-docs-webapp tomcat-javadoc
        sudo systemctl start tomcat
        sudo systemctl enable tomcat
        sudo apt-get install mysql-client -y
        cd /usr/local/bin
        sudo wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O cloud_sql_proxy
        sudo chmod +x cloud_sql_proxy
    SCRIPT
}

variable "autoscale_name"{
    default = "nginx-autoscale"
}

variable "nginx_ig_name" {
    default = "nginx-web"
}

variable "nginx_ig_base_name" {
    default = "web"
}

variable "nginx_zones" {
    default = ["us-central1-b"]
}

variable "tomcat_ig_name" {
    default = "tomcat"
}

variable "tomcat_zones" {
    default = ["us-central1-a", "us-central1-b", "us-central1-c"]
}

variable "hc_name" {
    default = "tomcat-healthcheck"
}

variable "backend_name" {
    default = "tomcat-backend-service"
}

variable "tomcat_forv_rule" {
    default = "tomcat-forwarding-rule"
}

variable "backend_name_nginx" {
    default = "nginx-backend-service"
}
