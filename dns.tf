resource "google_project_service" "dns" {
  service = "dns.googleapis.com"
  disable_dependent_services = true
}

resource "google_dns_record_set" "nginx" {
  name = "private-cluster.${google_dns_managed_zone.prod.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.prod.name

  rrdatas = ["34.116.145.176"]
}
resource "google_dns_managed_zone" "prod" {
  name     = "prod-zone"
  dns_name = var.dns_name

  depends_on = [
    google_project_service.dns
  ]
}
