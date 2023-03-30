terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.54.0"
    }
    }
  }

provider "google" {
  project = "project-381418"
  region = "europe-central2"
}

provider "google-beta" {
   project = "project-381418"
  region = "europe-central2"
  credentials = file("${local.credentials_file}")
}

data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${resource.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(resource.gke.ca_certificate)
}

provider "helm" {
  kubernetes {
   config_path = "~/.kube/config"
  }
}

terraform {
  backend "gcs" {
    bucket = "reece-project-backend-storage-bk1"
    prefix = "terraform/state"
  }
}






