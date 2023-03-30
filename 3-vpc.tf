resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
  disable_dependent_services = true
}

resource "google_project_service" "container" {
  service = "container.googleapis.com"
  disable_dependent_services = true
}

#resource "google_project_service" "artifactregistry" {
#  service = "artifactregistry.googleapis.com"
#}

resource "google_compute_network" "main" {
  name = "main"
  auto_create_subnetworks = false

  depends_on = [
    google_project_service.compute,
    google_project_service.container
  ]
}

resource "google_compute_subnetwork" "pri-sub" {
  name = "pri-sub"
  network = google_compute_network.main.id
  ip_cidr_range = "10.0.0.0/18"
  region = "europe-central2"
  private_ip_google_access = true

  secondary_ip_range  {
    range_name = "k8s-pod-range"
    ip_cidr_range = "10.1.0.0/16"
  }

  secondary_ip_range {
    ip_cidr_range = "10.2.0.0/20"
    range_name = "k8s-service-range"
  }
  depends_on = [
    google_compute_network.main
  ]
}