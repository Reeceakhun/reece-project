resource "google_container_cluster" "private-cluster" {
  name = "private-cluster"
  location = "europe-central2-b"
  remove_default_node_pool = true
  initial_node_count = 1
  network = google_compute_network.main.id
  subnetwork = google_compute_subnetwork.pri-sub.id
  logging_service = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"
  networking_mode = "VPC_NATIVE"


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
    workload_pool = "project-381418.svc.id.goog"
  }

  ip_allocation_policy {
    cluster_secondary_range_name = "k8s-pod-range"
    services_secondary_range_name = "k8s-service-range"
  }

  # to ensure the cluster is private
  private_cluster_config {
    enable_private_nodes = true
    enable_private_endpoint = false
    master_ipv4_cidr_block = "172.16.0.0/28"
  }
  depends_on = [
    google_project_service.container
  ]
}


