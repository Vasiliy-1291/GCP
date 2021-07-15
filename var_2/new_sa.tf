resource "google_project_iam_custom_role" "mycustomrole1" {
  role_id     = "mycustomrole1"
  title       = "my-custom-role-1"
  project     = var.project
  stage       = "ALPHA"
  description = "role with permissions to get files from all buckets and get information about VMs in project"
  permissions = ["compute.instances.get", "compute.instances.list", "storage.objects.get", "storage.objects.list"]
}

resource "google_service_account" "simanau-gke-1" {
  account_id   = "simanau-gke-1"
  display_name = "simanau-gke-1"
  description = "simanau-gke-1"
}

resource "google_project_iam_member" "custom-account-iam" {
  role = google_project_iam_custom_role.mycustomrole1.id
   member = "serviceAccount:${google_service_account.simanau-gke-1.email}"
}