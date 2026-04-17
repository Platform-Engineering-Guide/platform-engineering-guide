# variables.tf
variable "environment" {
  description = "Deployment environment (dev, staging, production)"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "production"], var.environment)
    error_message = "Environment must be dev, staging, or production."
  }
}

variable "service_name" {
  description = "Name of the service being provisioned"
  type        = string
}

# main.tf — RDS PostgreSQL instance with sensible platform defaults
resource "aws_db_instance" "service_database" {
  identifier        = "${var.service_name}-${var.environment}"
  engine            = "postgres"
  engine_version    = "16.2"
  instance_class    = local.db_instance_class[var.environment]
  allocated_storage = local.db_storage_gb[var.environment]

  db_name  = replace(var.service_name, "-", "_")
  username = "app_user"
  password = random_password.db_password.result

  # Security: no public access, encrypted at rest
  publicly_accessible    = false
  storage_encrypted      = true
  kms_key_id            = data.aws_kms_key.rds.arn

  # Backup: environment-appropriate retention
  backup_retention_period = local.backup_retention[var.environment]
  backup_window           = "03:00-04:00"
  maintenance_window      = "sun:04:00-sun:05:00"

  # Monitoring
  monitoring_interval             = 60
  monitoring_role_arn             = aws_iam_role.rds_monitoring.arn
  performance_insights_enabled    = true
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]

  # Deletion protection in production
  deletion_protection = var.environment == "production"

  tags = local.common_tags
}

locals {
  db_instance_class = {
    dev        = "db.t3.micro"
    staging    = "db.t3.small"
    production = "db.r6g.large"
  }
  db_storage_gb = {
    dev        = 20
    staging    = 50
    production = 200
  }
  backup_retention = {
    dev        = 1
    staging    = 7
    production = 30
  }
  common_tags = {
    Service     = var.service_name
    Environment = var.environment
    ManagedBy   = "terraform"
    CostCentre  = "platform-${var.environment}"
  }
}
