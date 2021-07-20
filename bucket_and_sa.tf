resource "google_storage_bucket" "simanau-config-bucket-task-6" {
  name          = "simanau-config-bucket-task-6"
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
  bucket = google_storage_bucket.simanau-config-bucket-task-6.name
  role = "roles/storage.objectCreator"
  member = "serviceAccount:${google_service_account.simanau-storage.email}"
}
