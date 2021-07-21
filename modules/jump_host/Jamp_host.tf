resource "google_compute_instance" "jump-host" {
  name           = var.name
  zone           = var.zone
  machine_type   = var.machine_type
  description    = "Jump-host"
  can_ip_forward = true

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.size
      type  = var.disk_type
    }
  }

  metadata = var.meta_ssh_key

  network_interface {
    network    = var.network_name
    subnetwork = var.subnetwork_pub_name

    access_config {
        // Ephemeral IP
    }
  }
}