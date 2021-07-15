variable "name" {
  type = string
  default = "vsimanau-cluster"
}

variable "project" {
  type = string
  default = "gcp-lab-1-vsimanau-319621"
}

variable "region" {
  type = string
  default = "us-central1"
}

variable "zone" {
  type = string
  default = "us-central1-a"
}

variable "initial_node_count" {
  default = 1
}

variable "machine_type" {
  type = string
  default = "n1-standard-1"
}

