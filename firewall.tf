resource "google_compute_firewall" "my-firewall-ingress" {
  name    = "my-firewall-ingress"
  network = google_compute_network.vasil-simanau-vpc.name
  description = "firewall for vasil-simanau-vpc ingress"
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports = ["1-65535"]
  }
}

resource "google_compute_firewall" "my-firewall-egress" {
  name    = "my-firewall-egress"
  network = google_compute_network.vasil-simanau-vpc.name
  description = "firewall for vasil-simanau-vpc egress"
  direction = "EGRESS"

  allow {
    protocol = "tcp"
    ports = ["22", "80"]
  }
}
