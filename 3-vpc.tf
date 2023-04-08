resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
  disable_dependent_services = true
}

resource "google_project_service" "container" {
  service = "container.googleapis.com"
  disable_dependent_services = true
}

resource "google_compute_network" "main" {
  name = var.network_name
  auto_create_subnetworks = false

  depends_on = [
    google_project_service.compute,
    google_project_service.container
  ]
}

resource "google_compute_subnetwork" "pri-sub" {
  name = var.subnetwork_name
  network = google_compute_network.main.id
  ip_cidr_range = var.subnetwork_ip_range
  region = var.region
  private_ip_google_access = true

  secondary_ip_range  {
    range_name = "k8s-pod-range"
    ip_cidr_range = var.pod_ip_range
  }
  secondary_ip_range {
    range_name = "k8s-service-range"
    ip_cidr_range = var.service_ip_range
  }

  depends_on = [
    google_compute_network.main
  ]
}