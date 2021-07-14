resource "google_storage_bucket" "simanau-config-bucket" {
  name          = "simanau-config-bucket"
  force_destroy = true
  storage_class = "STANDARD"
  location      = "US"
}


resource "google_service_account" "simanau-storage" {
  account_id   = "simanau-storage"
  display_name = "simanau-storage"
  description = "Service Account for simanau-config-storage"
}

resource "google_storage_bucket_iam_member" "member-simanau-storage" {
  bucket = google_storage_bucket.simanau-config-bucket.name
  role = "roles/storage.objectCreator"
  member = "serviceAccount:simanau-storage@gcp-lab-1-vsimanau-319621.iam.gserviceaccount.com"
}
