# account_vending/main.tf
resource "aws_organizations_account" "service_account" {
  name      = "${var.service_name}-${var.environment}"
  email     = "aws+${var.service_name}-${var.environment}@acme.io"
  role_name = "OrganizationAccountAccessRole"

  parent_id = data.aws_organizations_organizational_unit.target[var.environment].id

  tags = {
    ServiceName  = var.service_name
    Environment  = var.environment
    ManagedBy    = "platform-account-vending"
    CostCentre   = var.cost_centre
    Owner        = var.owner_team
  }

  lifecycle {
    # Prevent accidental account deletion
    prevent_destroy = true
    # Email cannot be changed after creation
    ignore_changes = [email]
  }
}

# Bootstrap the new account with baseline configuration
module "account_baseline" {
  source = "../../modules/account-baseline"

  account_id   = aws_organizations_account.service_account.id
  environment  = var.environment
  service_name = var.service_name

  # Networking
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones

  # Security tooling
  enable_cloudtrail      = true
  enable_config          = true
  enable_guardduty       = true
  enable_security_hub    = true
  security_hub_standards = ["aws-foundational-security-best-practices/v/1.0.0"]

  # GitOps integration
  argocd_role_arn = var.argocd_role_arn

  providers = {
    aws = aws.new_account
  }
}
