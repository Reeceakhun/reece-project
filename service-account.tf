resource "google_service_account" "myaccount" {
  account_id = "myaccount"
}

resource "google_project_iam_member" "myaccount" {
  project = "project-381418"
  role = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.myaccount.email}"
}

resource "google_service_account_iam_member" "myaccount" {
  service_account_id = google_service_account.myaccount.id
  role = "roles/iam.workloadIdentityUser"
  member = "serviceAccount:${google_service_account.myaccount.email}"
}

resource "null_resource" "create_keyfile" {
  provisioner "local-exec" {
    command = "gcloud iam service-accounts keys create key.json --iam-account myaccount@project-381418.iam.gserviceaccount.com"
  }
  depends_on = [
    google_service_account.myaccount
  ]
}

locals {
  credentials_file = "${path.cwd}/key.json"
}


