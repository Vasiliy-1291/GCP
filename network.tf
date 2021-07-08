resource "google_compute_network" "vasil-simanau-vpc" {
  name = var.network_name
  description = "My first network created by Terraform"
  auto_create_subnetworks = "false"
}