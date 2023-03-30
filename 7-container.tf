#resource "google_artifact_registry_repository" "reece-repository" {
#  repository_id = "reece-repository"
#  project = "project-381418"
#  location = "europe-central2"
#  format = "DOCKER"
#  depends_on = [
#    google_project_service.artifactregistry
#  ]
#}

#data "google_iam_policy" "admin" {
#  binding {
#    role = "roles/artifactregistry.reader"
#    members = [
#      "user:olukunleoluk10@gmail.com",
#    ]
#  }
#}

#resource "google_artifact_registry_repository_iam_policy" "policy" {
#  project = "project-381418"
#  location = "europe-central2"
#  repository = google_artifact_registry_repository.reece-repository.name
#  policy_data = data.google_iam_policy.admin.policy_data
#}