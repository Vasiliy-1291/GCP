resource "google_project_iam_custom_role" "my-custom-role" {
  role_id     = "mycustomrole"
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
  role = "projects/gcp-lab-2-vsimanau/roles/mycustomrole"
  member = "serviceAccount:${google_service_account.simanau-gke.email}"
}
