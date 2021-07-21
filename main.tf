provider "google" {
  project = var.project
  region  = var.region
}

module "network" {
  source = "./modules/network"
}

module "jump_host" {
  source = "./modules/jump_host"
}

# template nginx
resource "google_compute_instance_template" "nginx" {
    name         = var.nginx_name
    region       = var.region
    machine_type = var.machine_type
    description  = "centos with nginx"

    disk  {
      source_image = var.image
      auto_delete  = true
      boot         = true
      disk_size_gb = 20
      disk_type    = "pd-ssd"
    }

    metadata                = var.my_ssh_key
    metadata_startup_script = var.nginx_script

    network_interface {
    network    = "vasil-simanau-vpc"
    subnetwork = "vasil-simanau-vpc-public-subnetwork"
    }
}

# template tomcat and cloudsql_proxy
resource "google_compute_instance_template" "tomcat" {
    name         = var.tomcat_name
    region       = var.region
    machine_type = var.machine_type
    description  = "Centos 7 with tomcat and cloudSQL_proxy"

    disk  {
      source_image = var.image
      auto_delete  = true
      boot         = true
      disk_size_gb = 20
      disk_type    = "pd-ssd"
    }
    
    metadata = var.my_ssh_key

    metadata_startup_script = var.tomcat_script

    network_interface {
    network    = "vasil-simanau-vpc"
    subnetwork = "vasil-simanau-vpc-privat-subnetwork"
  }
}


# Create nginx instans group
resource "google_compute_region_autoscaler" "nginx-autoscale" {
  name   = var.autoscale_name
  target = google_compute_region_instance_group_manager.nginx.id
  region = var.region

  autoscaling_policy {
    max_replicas    = "3"
    min_replicas    = "1"
  }
}

resource "google_compute_region_instance_group_manager" "nginx" {
  name                       = var.nginx_ig_name
  base_instance_name         = var.nginx_ig_base_name
  region                     = var.region
  distribution_policy_zones  = var.nginx_zones

  version {
    instance_template = google_compute_instance_template.nginx.id
  }
  named_port {
    name = "http"
    port = 80
  }
  named_port {
    name = "ssh"
    port = 22
  }
}

# Create tomcat instance group
resource "google_compute_region_instance_group_manager" "tomcat" {
  name = var.tomcat_ig_name
  base_instance_name         = var.tomcat_ig_name
  region                     = var.region
  distribution_policy_zones  = var.tomcat_zones

  version {
    instance_template = google_compute_instance_template.tomcat.id
  }

  target_size  = 3

  named_port {
    name = "http"
    port = 8081
  }
  named_port {
    name = "ssh"
    port = 22
  }
  named_port {
    name = "custom"
    port = 5432
  }
}

resource "google_compute_global_forwarding_rule" "global-forwarding-rule" {
  name       = "global-forwarding-rule"
  target     = google_compute_target_http_proxy.target-http-proxy.id
  port_range = "80"
}

resource "google_compute_target_http_proxy" "target-http-proxy" {
  name    = "target-http-proxy"
  url_map = google_compute_url_map.url-map.id
}

resource "google_compute_url_map" "url-map" {
  name            = "url-map"
  default_service = google_compute_backend_service.nginx-backend.id
}

resource "google_compute_backend_service" "nginx-backend" {
  name                    = var.backend_name_nginx
  port_name               = "http"
  protocol                = "HTTP"
  health_checks           = [google_compute_health_check.http-healthcheck.id]

#  backend {
#    group                 = google_compute_region_instance_group_manager.nginx.id
#    balancing_mode        = "RATE"
#    capacity_scaler       = 0.4
#    max_rate_per_instance = 50
#  }
}

resource "google_compute_health_check" "http-healthcheck" {
  name               = "http-healthcheck"
  timeout_sec        = 1
  check_interval_sec = 1
  http_health_check {
    port = 80
  }
}



resource "google_compute_region_backend_service" "tomcat-backend" {
  name             = var.backend_name
  protocol         = "TCP"
  timeout_sec      = 10
  session_affinity = "NONE"#
  
#  backend {
#    group = google_compute_region_instance_group_manager.tomcat.id
#  }

  health_checks = ["${google_compute_health_check.tomcat-healthcheck.self_link}"]
}

resource "google_compute_forwarding_rule" "tomcat-forwarding-rule" {
  name                  = var.tomcat_forv_rule
  load_balancing_scheme = "INTERNAL"
  backend_service       = google_compute_region_backend_service.tomcat-backend.self_link
  ports                 = [ "5432" ]
  network               = "vasil-simanau-vpc"
  subnetwork            = "vasil-simanau-vpc-privat-subnetwork"
}



resource "google_compute_health_check" "tomcat-healthcheck" {
  name               = var.hc_name
  check_interval_sec = 5
  timeout_sec        = 5
  tcp_health_check {
    port = "5432"
  }
}

