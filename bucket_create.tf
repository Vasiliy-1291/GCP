resource "google_storage_bucket" "my-bucket-3-nearline" {
  name          = "my-bucket-3-nearline"
  force_destroy = true
  storage_class = "NEARLINE"
  lifecycle_rule {
      condition {
        age = "2"
      }
      action {
        type = "SetStorageClass"
        storage_class = "COLDLINE"
      }
    }
}

resource "google_storage_bucket" "my-bucket-4-coldline" {
  name          = "my-bucket-4-coldline"
  force_destroy = true
  storage_class = "COLDLINE"


  lifecycle_rule {
    condition {
      age = "3"
    }
    action {
      type = "Delete"
    }
  }
}