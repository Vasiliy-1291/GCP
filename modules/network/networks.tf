resource "google_compute_network" "vasil-simanau-vpc" {
  name                    = var.network_name
  project                 = var.project
  description             = "My network for final task"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "public-subnetwork" {
  name          = "${var.network_name}-public-subnetwork"
  region        = var.region
  ip_cidr_range = var.pub_range
  network       = google_compute_network.vasil-simanau-vpc.id
}

resource "google_compute_subnetwork" "privat-subnetwork" {
  name          = "${var.network_name}-privat-subnetwork"
  region        = var.region
  ip_cidr_range = var.priv_range
  network       = google_compute_network.vasil-simanau-vpc.id
}

