variable "project" {
  type        = string
  default     = "gcp-lab-2-vsimanau"
  description = "Name of project"
}

variable "network_name" {
  type        = string
  default     = "vasil-simanau-vpc"
  description = "Name of VPC network"
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "route_mode" {
    type        = string
    default     = "REGIONAL"
    description = "VPC routing mode"
}

variable "pub_range" {
    type        = string
    default     = "10.4.1.0/24"
    description = "Range IP for Public subnetwork"
}

variable "priv_range" {
    type        = string
    default     = "10.4.2.0/24"
    description = "Range IP for Privat subnetwork"
}





