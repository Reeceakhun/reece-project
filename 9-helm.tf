resource "helm_release" "nginx" {
  name       = "nginx"
  chart      = "${path.module}/helm-chart"
  namespace  = "default"
  depends_on = [
    null_resource.provisioner
  ]
  timeout = 3600

#  set {
#    name  = "image.reece-repository"
#    value = "nginx"
#  }
#  set {
#    name  = "image.tag"
#    value = "latest"
#  }
#  set {
#    name  = "replicaCount"
#    value = "3"
#  }
  set {
    name = "service_account" 
    value = "google_service_account.myaccount.email"
  }
}
