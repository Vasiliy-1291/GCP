resource "google_compute_firewall" "allow-ingress" {
  name    = "allow-unternal"
  network = google_compute_network.vasil-simanau-vpc.name
  direction = "INGRESS"

  allow {
    protocol = "ICMP"
  }

  allow {
    protocol = "TCP"
    ports    = ["22", "22", "5432", "8081"]
  }

}

resource "google_compute_firewall" "my-firewall-egress" {
  name    = "my-firewall-egress"
  network = google_compute_network.vasil-simanau-vpc.name
  description = "firewall for vasil-simanau-vpc egress"
  direction = "EGRESS"

  allow {
    protocol = "tcp"
    ports = ["0-65535"]
  }
}