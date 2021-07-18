resource "google_cloud_run_service" "run-flask" {
  name = "my-flask"
  location = "us-central1"
  template {
    spec {
      service_account_name = google_service_account.service-cloudrun.email
      containers {
        image = "gcr.io/gcp-lab-vsimanau/flask@sha256:87ad48860ec2fef2efb6b6278316ca17b02a29c38eb0baa3fafa1160e4a4352f"
      }
    }
  }
  traffic {
    percent         = 100
    latest_revision = true
  }
  depends_on = [google_project_service.run-api]
}

output "url-maven" {
  value = "${google_cloud_run_service.run-flask.status[0].url}"
}
