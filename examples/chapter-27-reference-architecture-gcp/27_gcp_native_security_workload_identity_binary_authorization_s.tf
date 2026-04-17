# terraform: create GCP service account and bind to Kubernetes service account
resource "google_service_account" "payments_api" {
  account_id   = "payments-api"
  display_name = "Payments API Service Account"
  project      = var.project_id
}

# Grant the GCP service account the minimum necessary permissions
resource "google_project_iam_member" "payments_api_secret_accessor" {
  project = var.project_id
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:${google_service_account.payments_api.email}"

  condition {
    title      = "payments-secrets-only"
    expression = "resource.name.startsWith(\"projects/${var.project_id}/secrets/payments/\")"
  }
}

# Allow the Kubernetes service account to impersonate the GCP service account
resource "google_service_account_iam_member" "payments_api_workload_identity" {
  service_account_id = google_service_account.payments_api.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project_id}.svc.id.goog[payments-production/payments-api]"
}
