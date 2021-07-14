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

resource "google_project_iam_custom_role" "my-custom-role" {
  role_id     = "MyCustomRole"
  title       = "my-custom-role"
  description = "role with permissions to get files from all buckets and get information about VMs in project"
  project = var.project
  stage = "ALPHA"
  permissions = ["compute.instances.get", "compute.instances.list", "storage.objects.get", "storage.objects.list"]
}

resource "google_service_account" "simanau-gke" {
  account_id   = "simanau-gke"
  display_name = "simanau-gke"
  description = "simanau-gke"
}

resource "google_project_iam_member" "custom-account-iam" {
  role = "projects/gcp-lab-1-vsimanau-319621/roles/MyCustomRole"
  member = "serviceAccount:simanau-gke@gcp-lab-1-vsimanau-319621.iam.gserviceaccount.com"
}