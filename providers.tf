data "google_client_config" "provider" {}

provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

provider "kubernetes" {
  host = "https://${google_container_cluster.simanau-cluster.endpoint}"
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.simanau-cluster.master_auth[0].cluster_ca_certificate)
}
