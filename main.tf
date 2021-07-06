terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  project = "gcp-lab-1-vsimanau"
}

resource "google_compute_instance" "terraform-vm-vsimanau" {
  name = "terraform-vm-vsimanau"
  zone = "europe-central2-a"
  machine_type = "e2-standard-2"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
      size = "10"
      }
    }

  network_interface {
  network = "default"

  access_config {
    // Ephemeral IP
  }
}
}
