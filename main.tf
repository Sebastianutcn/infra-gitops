provider "google" {
  project     = "gitops-457111"
  region      = "europe-west1"
  zone        = "europe-west1-b"
}

resource "google_compute_instance" "gitops_vm" {
  name         = "vm-instance"
  machine_type = "e2-medium"
  zone         = "europe-west1-b"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }
  }
}

resource "google_storage_bucket" "gitops_bucket" {
  name     = "gitops-bucket-457111"
  location = "EU"
  force_destroy = true
}



