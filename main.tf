
resource "google_container_cluster" "simanau-cluster" {
  name     = "simanau-cluster"
  location = var.zone
  remove_default_node_pool = true
  initial_node_count       = 1
  workload_identity_config {
    identity_namespace      = "gcp-lab-2-vsimanau.svc.id.goog"
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
  name       = "svsworkload"
  namespace  = kubernetes_namespace.nginxnamespace.metadata.0.name
  project_id = var.project
  roles = ["projects/gcp-lab-2-vsimanau/roles/mycustomrole"]
}


resource "kubernetes_namespace" "nginxnamespace" {
  metadata {
    annotations = {
      name = "nginxnamespace"
    }
    name = "nginxnamespace"
  }
}
