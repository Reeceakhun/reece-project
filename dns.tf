resource "google_project_service" "dns" {
  service = "dns.googleapis.com"
  disable_dependent_services = true
}

resource "google_dns_managed_zone" "akhun_pl" {
  name        = "akhun-pl"
  dns_name    = "akhun.pl."
  description = "akhun.pl DNS zone"
  depends_on = [
    google_project_service.dns
  ]
  

#  labels = {
#    name = "nginx_service"
#    app = nginx
#  }
}

variable "domains" {
  type = set(string)
  default = []
}

resource "google_dns_record_set" "domain" {
  for_each = var.domains

  name = "akhun.pl."
  type = "A"
  ttl  = 300
  provider = google-beta
  managed_zone = google_dns_managed_zone.akhun_pl.name
  rrdatas = ["34.118.36.95"]
}




