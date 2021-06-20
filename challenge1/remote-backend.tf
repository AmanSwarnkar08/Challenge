terraform {
  backend "gcs" {
    bucket  = "bucket-name-to-store-tfstate-file"
    prefix  = "state/devops"
  }
}
