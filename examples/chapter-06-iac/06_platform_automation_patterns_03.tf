module "service_database" {
  source  = "registry.acme.io/platform/service-database/aws"
  version = "~> 2.3"  # Allow patch updates, pin minor version

  service_name = var.service_name
  environment  = var.environment
  tier         = "medium"
}
