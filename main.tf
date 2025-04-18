provider "google" {
#   credentials = var.credentials
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

    access_config {}
  }

  advanced_machine_features {
    enable_nested_virtualization = true
  }
  
  metadata_startup_script = file("scripts/startup-script.sh")

}