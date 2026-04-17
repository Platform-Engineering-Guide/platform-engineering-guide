# terraform/modules/compliant-rds/main.tf
# Every RDS instance provisioned through this module meets NHS IG requirements
resource "aws_db_instance" "this" {
  identifier     = var.identifier
  engine         = "postgres"
  engine_version = "16.1"

  # Compliance: encryption always enabled — not configurable
  storage_encrypted = true
  kms_key_id        = var.kms_key_id   # Organisation-managed key required

  # Compliance: audit logging always enabled
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]

  # Compliance: automated backups with retention meeting NHS IG requirement
  backup_retention_period = 35   # 35 days: exceeds NHS 30-day minimum
  backup_window           = "02:00-04:00"
  maintenance_window      = "sun:04:00-sun:06:00"

  # Compliance: deletion protection always enabled
  deletion_protection = true

  # Compliance: no public access
  publicly_accessible = false

  # Compliance: Multi-AZ for HA (required for clinical production databases)
  multi_az = var.environment == "production" ? true : false

  # Compliance: enforce SSL connections
  parameter_group_name = aws_db_parameter_group.enforce_ssl.name

  tags = merge(var.tags, {
    "compliance:framework"         = "DSPT,MDR"
    "compliance:data-class"        = var.data_classification
    "compliance:nhs-org"           = var.nhs_org_code
    "compliance:last-reviewed"     = var.compliance_review_date
    "compliance:reviewed-by"       = var.compliance_reviewer
  })
}

resource "aws_db_parameter_group" "enforce_ssl" {
  family = "postgres16"
  name   = "${var.identifier}-ssl-enforced"

  parameter {
    name         = "rds.force_ssl"
    value        = "1"
    apply_method = "immediate"
  }
}
