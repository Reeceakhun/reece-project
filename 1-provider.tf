terraform {
   backend "gcs" {
    bucket = "reece-project-backend-storage-bk1"
    prefix = "terraform/state"
  }
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.54.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.9.0"
    }
  }
}
provider "google" {
  project = var.project_id
  region = var.zone
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





