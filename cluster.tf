resource "google_container_cluster" "sql-cluster" {
  name                     = "sql-cluster"
  location                 = "us-central1-a"
  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "sql-node-pool" {
  name       = "sql-node-pool"
  location   = "us-central1-a"
  cluster    = google_container_cluster.sql-cluster.name
  node_count = 1

  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "kubernetes_namespace" "sqlnamespace" {
  metadata {
    name = "sqlnamespace"
  }
}
