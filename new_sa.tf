resource "google_service_account" "simanau-gke" {
  account_id   = "simanau-gke"
  display_name = "simanau-gke"
  description = "simanau-gke"
}

resource "google_service_account_iam_binding" "castom-iam" {
  service_account_id = google_service_account.simanau-gke.name
  role               = "projects/gcp-lab-1-vsimanau-319621/roles/MyCustomRole"
  members = ["serviceAccount:simanau-gke@gcp-lab-1-vsimanau-319621.iam.gserviceaccount.com"]
}