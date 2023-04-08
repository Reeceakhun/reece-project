resource "google_container_cluster" "private-cluster" {
  name = var.cluster_name
  location = var.zone
  remove_default_node_pool = true
  initial_node_count = 1
  network = google_compute_network.main.id
  subnetwork = google_compute_subnetwork.pri-sub.id
  logging_service = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"
  networking_mode = var.network_mode


#want to replace the http load balancer with nginx ingress controller
  addons_config {
    http_load_balancing {
      disabled = true
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
  }
  #to manage kubernetes cluster upgrade
  release_channel {
    channel = "REGULAR"
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  ip_allocation_policy {
    cluster_secondary_range_name = "k8s-pod-range"
    services_secondary_range_name = "k8s-service-range"
  }

  # to ensure the cluster is private
  private_cluster_config {
    enable_private_nodes = true
    enable_private_endpoint = false
    master_ipv4_cidr_block = var.master_ipv4_cidr
  }
  depends_on = [
    google_project_service.container
  ]
}


