resource "google_compute_subnetwork" "public-network" {
  name          = "public-network"
  ip_cidr_range = "10.4.1.0/24"
  network       = google_compute_network.vasil-simanau-vpc.id
}

resource "google_compute_subnetwork" "privat-network" {
  name          = "privat-network"
  ip_cidr_range = "10.4.2.0/24"
  network       = google_compute_network.vasil-simanau-vpc.id
}