resource "google_project_iam_custom_role" "my-custom-role" {
  role_id     = "MyCustomRole"
  title       = "my-custom-role"
  description = "role with permissions to get files from all buckets and get information about VMs in project"
  permissions = ["storage.objects.get", "compute.instances.get"]
}