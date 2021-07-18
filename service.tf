resource "google_service_account" "service-cloudrun" {
  account_id   = "service-cloudrun"
  display_name = "service-cloudrun"
}

resource "google_project_iam_member" "cloudrun-iam-1" {
  role = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.service-cloudrun.email}"
}

resource "google_project_iam_member" "cloudrun-iam-2" {
  role = "roles/memcache.admin"
  member = "serviceAccount:${google_service_account.service-cloudrun.email}"
}

resource "google_project_iam_member" "cloudrun-iam-3" {
  role = "roles/datastore.user"
  member = "serviceAccount:${google_service_account.service-cloudrun.email}"
}

resource "google_project_iam_member" "cloudrun-iam-4" {
  role = "roles/cloudsql.admin"
  member = "serviceAccount:${google_service_account.service-cloudrun.email}"
}

data "google_iam_policy" "all-run" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth_flask" {
  location    = google_cloud_run_service.run-flask.location
  project     = google_cloud_run_service.run-flask.project
  service     = google_cloud_run_service.run-flask.name
  policy_data = data.google_iam_policy.all-run.policy_data
}