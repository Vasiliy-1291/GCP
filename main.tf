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

resource "google_container_cluster" "simanau-cluster" {
  name     = "simanau-cluster"
  location = var.zone
  remove_default_node_pool = true
  initial_node_count       = 1
  workload_identity_config {
    identity_namespace = "nginxnamespace.svc.id.goog"
  }
}

resource "google_container_node_pool" "nginx-simanau-pool" {
  name       = "nginx-simanau-pool"
  location   = var.zone
  cluster    = google_container_cluster.simanau-cluster.name
  node_count = 1

  node_config {
    machine_type = "n1-standard-1"
  }
}

module "my-app-workload-identity" {
  source     = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  cluster_name = google_container_cluster.simanau-cluster.name
  name       = "simanauidentity"
  namespace  = kubernetes_namespace.nginxnamespace.metadata.0.name
  project_id = var.project
  roles = ["projects/gcp-lab-1-vsimanau-319621/roles/my-custom-role"]
}


resource "kubernetes_namespace" "nginxnamespace" {
  metadata {
    annotations = {
      name = "nginxnamespace"
    }
    name = "nginxnamespace"
  }
}