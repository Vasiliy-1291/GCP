terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

variable "instance_name" {
  type = string
}

variable "zone" {
  type = string
}

variable "machine_type" {
  type = string
}

variable "image" {
  type = string
}

variable "labels" {
  type = map
}

variable "description" {
  type = string
}

variable "disk_size" {
  type = string
}

variable "disk_type" {
  type = string
}

variable "my_skript" {
  type = string
}

variable "delete_timeout" {
  type = string
}


provider "google" {
  project = "gcp-lab-1-vsimanau"
}

resource "google_compute_instance" "nginx-terraform" {
  name = var.instance_name
  zone = var.zone
  machine_type = var.machine_type

  boot_disk {
    initialize_params {
      image = var.image
      size = var.disk_size
      type = var.disk_type
      }
    }

  tags = ["http-server","https-server",]

  deletion_protection = "true"

  labels = var.labels

  metadata_startup_script = var.my_skript

  network_interface {
  network = "default"
  access_config {
    // Ephemeral IP
  }
  }

  timeouts {
    delete = var.delete_timeout
  }
}

output "URL" { 
  value = "http://${google_compute_instance.nginx-terraform.network_interface.0.access_config.0.nat_ip}/"
}

resource "google_compute_disk" "nginx-gcp-ui-1" {
  name  = "nginx-gcp-ui-1"
  type  = "pd-ssd"
  zone  = "us-central1-c"
  description = "New disk for nginx-terraform"
  size = 10
}

resource "google_compute_attached_disk" "attached_nginx-gcp-ui-1" {
  disk     = google_compute_disk.nginx-gcp-ui-1.id
  instance = google_compute_instance.nginx-terraform.id
}