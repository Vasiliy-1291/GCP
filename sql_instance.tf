resource "google_compute_network" "private_network" {
  name = "private-network"
  auto_create_subnetworks = false
}

resource "google_compute_firewall" "my-firewall" {
  name    = "my-firewall"
  network = google_compute_network.private_network.name
  description = "firewall for privat tetwork ingress"
  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports = ["22", "80", "3306"]
  }
}

resource "google_compute_global_address" "private_ip_address" {
  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.private_network.id
}

resource "google_service_networking_connection" "private_vpc_connection" {

  network                 = google_compute_network.private_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_sql_database_instance" "master" {
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
resource "google_sql_database" "database" {
  name     = "my-database"
  instance = google_sql_database_instance.master.name
}

resource "google_service_account" "simanau-sql" {
  account_id   = "simanau-sql"
  display_name = "simanau-sql"
  description = "Service Account for sql"
}