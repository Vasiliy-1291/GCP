resource "google_container_cluster" "sql-cluster" {
  name                     = "sql-cluster"
  location                 = var.zone
  ip_allocation_policy {}
  initial_node_count       = 1
  workload_identity_config {
    identity_namespace = "${var.project}.svc.id.goog"
  }
}

resource "google_container_node_pool" "sql-node-pool" {
  name       = "sql-node-pool"
  location   = var.zone
  cluster    = google_container_cluster.sql-cluster.name
  node_count = 1

  node_config {
    machine_type = "n1-standard-1"
  }
}

module "workload-identity" {
  source     = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  cluster_name = google_container_cluster.sql-cluster.name
  name       = "sqlservice"
  namespace  = kubernetes_namespace.sqlnamespace.metadata.0.name
  project_id = var.project
  roles = ["roles/cloudsql.admin"]
}

resource "kubernetes_namespace" "sqlnamespace" {
  metadata {
    name = "sqlnamespace"
  }
}
