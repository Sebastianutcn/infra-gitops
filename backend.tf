terraform {
  backend "gcs" {
    bucket  = "gitops-state-backend-bucket"
    prefix  = "gitops-demo"
  }
}


