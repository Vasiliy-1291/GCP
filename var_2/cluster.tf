resource "google_container_cluster" "vsimanau-cluster" {
  name                     = "vsimanau-cluster"
  project                  = var.project
  description              = "Simanau GKE Cluster"
  location                 = var.region

  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "vsimanau-pool" {
  name       = "vsimanau-cluster-node-pool"
  project    = var.project
  location   = var.region
  cluster    = google_container_cluster.vsimanau-cluster.name
  node_count = 1

  node_config {
    machine_type = var.machine_type
  }
}

module "my-app-workload-identity" {
  source    = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  cluster_name = google_container_cluster.vsimanau-cluster.name
  use_existing_k8s_sa = true
  name                = "simanau-wli"
  namespace           = "default"
  project_id          = var.project
  roles = ["projects/gcp-lab-1-vsimanau-319621/roles/mycustomrole1"]
}