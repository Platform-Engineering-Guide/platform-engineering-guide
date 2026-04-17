# terraform/modules/gcp-project/main.tf
module "workloads_production" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 15.0"

  name              = "workloads-production"
  random_project_id = false
  org_id            = var.org_id
  folder_id         = google_folder.production.id
  billing_account   = var.billing_account_id

  activate_apis = [
    "container.googleapis.com",          # GKE
    "compute.googleapis.com",            # Compute Engine
    "iam.googleapis.com",                # IAM
    "cloudresourcemanager.googleapis.com",
    "secretmanager.googleapis.com",      # Secret Manager
    "monitoring.googleapis.com",         # Cloud Monitoring
    "logging.googleapis.com",            # Cloud Logging
    "artifactregistry.googleapis.com",   # Container image registry
    "servicenetworking.googleapis.com",  # VPC peering for managed services
  ]

  default_service_account = "keep"

  labels = {
    environment = "production"
    managed-by  = "terraform"
    team        = "platform"
  }
}
