variable "name" {
  type = string
  default = "jump-host"
  description = "Name of Instance"
}

variable "zone" {
  type = string
  default = "us-central1-c"
  description = "Zone of Instance"
}

variable "machine_type" {
  type = string
  default = "n1-standard-1"
  description = "Type of Instance"
}

variable "image"{
  type = string
  default = "centos-cloud/centos-7"
  description = "Image of Instance"
}

variable "size" {
    default = 20
    description = "Size hard disk"
}
variable "disk_type" {
    default = "pd-ssd"
    description = "Type hard disk"
}

variable "meta_ssh_key" {
    default = {
      ssh-keys = "vasil:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDkUTyHgRQPbgXBNxoHJccJeBUw629ju2u3q16PQZqcJzHD5A9Ygv/VfqtTMU1VK/ziUfPgBF4mjeVpYAS4PUYoiHCD4cSvxa0HVXJtr6NKGWU8y6TtT0vV3s7gg11FOVGd7JI6g6N+z3+blQ3PHNRw3R1Y1O4UA26a4RSD6B9hNZZQvCwTk/bB22nw/Rf+Jz8yJFCWSugBIGAW3DfcRGpeYnCaKEfWqkFvlosMOHGEFNNXLVx2sTCK9oriASruG6nK5nTFVQXXsPGJGwyz5VuOIGv9jW5k1swBZEOC+SS7cTxN/wMwtv10lXyfbKFgs33sMvoeEEDilx+WSD6CWsHEd0LWuM0AvCrkbv7v1HmU/YZWw9sYplqoDeb01tuTSfXpeu1X/OQJYIz50x93Fdjk7iT9TKTTmJn7i2TW3vdqaJgLd/JMvkJQM9xHEwHa5+W7nUm1jw0Wd/ClWl1KTGHT+jHlwVSi29HkHIvNffhA29A8BvH6Q8a+FTVlxpPiVUM= vasil@EPBYMINW16B1"
    }
}

variable "network_name" {
    default = "vasil-simanau-vpc"
}

variable "subnetwork_pub_name" {
    default = "vasil-simanau-vpc-public-subnetwork"
}
