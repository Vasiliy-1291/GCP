resource "kubernetes_secret" "sql-secret" {
  metadata {
    name = "sql-auth"
    namespace = kubernetes_namespace.sqlnamespace.metadata.0.name
  }
  data = {
    password = random_password.password.result
  }
}

resource "kubernetes_config_map" "sql-script" {
  metadata {
    name = "sql-script"
    namespace = kubernetes_namespace.sqlnamespace.metadata.0.name
  }
  data = {
    "script.sql" = "${file("/home/vasil/GCP/skript.sql")}"
  }
}

resource "kubernetes_deployment" "deployment" {
  metadata {
    name = "deployment"
    namespace = kubernetes_namespace.sqlnamespace.metadata.0.name
    labels = {
      app = "sql"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "sql"
      }
    }
    template {
      metadata {
        labels = {
          app = "sql"
        }
      }
      spec {
        container {
          image = "gcr.io/cloudsql-docker/gce-proxy:1.20.0"
          name  = "sql-instance"
          command = ["/cloud_sql_proxy", "-instances=${google_sql_database_instance.master.connection_name}=tcp:3306"]
        }
        container {
          image = "google/cloud-sdk"
          name  = "sql-client"
          command = ["bash", "-c", "apt-get install -y default-mysql-client; mysql --password=$MYPASSWORD --user=simanau_db_user --host=127.0.0.1 --port=3306 --database=${google_sql_database.database.name} < /home/vasil/GCP/skript.sql; sleep 10000"]
          env {
            name = "MYPASSWORD"
            value_from {
              secret_key_ref {
                key  = "password"
                name = kubernetes_secret.sql-secret.metadata.0.name
              }
            }
          }
          volume_mount {
            name = "workdir"
            mount_path = "/home/vasil/GCP"
          }
        }
        service_account_name = module.workload-identity.k8s_service_account_name
        volume {
          name = "workdir"
          config_map {
            name = kubernetes_config_map.sql-script.metadata.0.name
            items {
              key = "script.sql"
              path = "script.sql"
            }
          }
        }
      }
    }
  }
}
