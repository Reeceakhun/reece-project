resource "google_container_node_pool" "node_pool" {
  name = "node-pool"
  cluster = google_container_cluster.private-cluster.id
  node_count = 2
  location = "europe-central2-b"

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

#resource "kubernetes_namespace" "reece_namespace" {
#  metadata {
#    name = "reece-namespace"
#  }
#}
resource "null_resource" "provisioner" {
  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials private-cluster --zone europe-central2-b --project project-381418"
  }
  depends_on = [
    google_container_node_pool.node_pool
  ]
}