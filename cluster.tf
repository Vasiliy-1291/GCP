resource "google_container_cluster" "default" {
  name        = var.name
  project     = var.project
  description = "Simanau GKE Cluster"
  location    = var.location

  remove_default_node_pool = true
  initial_node_count       = var.initial_node_count
}

resource "google_container_node_pool" "default" {
  name       = "${var.name}-node-pool"
  project    = var.project
  location   = var.location
  cluster    = google_container_cluster.default.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = var.machine_type
    service_account = "simanau-gke@gcp-lab-1-vsimanau-319621.iam.gserviceaccount.com"
  }
}
