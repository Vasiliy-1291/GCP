resource "google_project_iam_custom_role" "mycustomrole2" {
  role_id     = "mycustomrole2"
  title       = "my-custom-role-2"
  project     = var.project
  stage       = "ALPHA"
  description = "role with permissions to get files from all buckets and get information about VMs in project"
  permissions = ["compute.instances.get", "compute.instances.list", "storage.objects.get", "storage.objects.list"]
}

resource "google_service_account" "simanau-gke-2" {
  account_id   = "simanau-gke-2"
  display_name = "simanau-gke-2"
  description = "simanau-gke-2"
}

resource "google_project_iam_member" "custom-account-iam" {
  role = google_project_iam_custom_role.mycustomrole2.id
   member = "serviceAccount:${google_service_account.simanau-gke-2.email}"
}