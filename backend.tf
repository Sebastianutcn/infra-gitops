terraform {
  backend "gcs" {
    bucket  = " state-bucket-gitops"
    prefix  = "gitops-demo"
  }
}
