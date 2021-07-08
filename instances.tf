resource "google_compute_instance" "nginx-terraform-whith-subnets" {
  name = var.instance_name
  zone = var.zone
  machine_type = var.machine_type
  labels = var.labels
  metadata_startup_script = var.my_skript

  boot_disk {
    initialize_params {
      image = var.image
      size = var.disk_size
      type = var.disk_type
      }
    }

  tags = ["http-server","https-server",]

  network_interface {
  network = "vasil-simanau-vpc"
  subnetwork = "public-network"
  access_config {
    // Ephemeral IP
  }
  }


}

output "URL" { 
  value = "http://${google_compute_instance.nginx-terraform-whith-subnets.network_interface.0.access_config.0.nat_ip}/"
}