resource "google_compute_network" "private_network" {
#  provider = google-beta
  name = "private-network"
  auto_create_subnetworks = false
}

resource "google_compute_global_address" "private_ip_address" {
#  provider = google-beta

  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.private_network.id
}

resource "google_service_networking_connection" "private_vpc_connection" {
#  provider = google-beta

  network                 = google_compute_network.private_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_sql_database_instance" "master" {
#  provider = google-beta

  name   = "private-instance-${random_id.db_name_suffix.hex}"
  region = "us-central1"
  database_version = "MYSQL_8_0"

  depends_on = [google_service_networking_connection.private_vpc_connection]

  settings {
    tier = "db-f1-micro"
    availability_type = "REGIONAL"

    backup_configuration {
      enabled            = true
      binary_log_enabled = true
    }

    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.private_network.id
    }
  }
}

provider "google-beta" {
  region = "us-central1"
  zone   = "us-central1-a"
}

resource "random_password" "password" {
  length           = 8
  special          = true
  override_special = "_%@"
}

resource "google_sql_user" "castom-user" {
  name     = "simanau_db_user"
  instance = google_sql_database_instance.master.name
  password = random_password.password.result
}

output "db_password" {
  sensitive = true
  value     = "dbname_custom: ${random_password.password.result}"
}

resource "google_sql_database" "database" {
  name     = "my-database"
  instance = google_sql_database_instance.master.name
}

resource "google_service_account" "simanau-sql" {
  account_id   = "simanau-sql"
  display_name = "simanau-sql"
  description = "Service Account for sql"
}

resource "google_storage_bucket_iam_member" "member-simanau-storage" {
  bucket = google_storage_bucket.simanau-config-bucket.name
  role = "roles/storage.objectCreator"
  member = "serviceAccount:simanau-storage@gcp-lab-1-vsimanau-319621.iam.gserviceaccount.com"
