terraform {
  backend "gcs" {
    bucket  = "bucket-for-final-task"
    prefix  = "terraform/state"
  }
}
