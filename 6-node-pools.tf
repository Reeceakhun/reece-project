resource "google_container_node_pool" "node_pool" {
  name = "node-pool"
  cluster = google_container_cluster.private-cluster.id
  location = var.zone
  node_count = var.node_count

  node_config {
    preemptible = false
    machine_type = "e2-small"
    disk_size_gb = 50
    disk_type = "pd-ssd"

    labels = {
      role = "general"
    }

    service_account = google_service_account.myaccount.email
    oauth_scopes =[
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
  management {
    auto_repair = true
    auto_upgrade = true
  }
  depends_on = [
    google_container_cluster.private-cluster
  ]
}


resource "null_resource" "provisioner" {
  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials private-cluster --zone ${var.zone} --project ${var.project_id}"
  }
  depends_on = [
    google_container_node_pool.node_pool
  ]
}

