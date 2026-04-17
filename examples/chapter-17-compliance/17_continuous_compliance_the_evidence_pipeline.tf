# Terraform: S3 bucket with Object Lock for compliance evidence
resource "aws_s3_bucket" "compliance_evidence" {
  bucket = "acme-compliance-evidence-${var.environment}"

  object_lock_enabled = true

  tags = {
    Purpose        = "compliance-evidence"
    DataClass      = "audit-log"
    RetentionYears = "7"
  }
}

resource "aws_s3_bucket_object_lock_configuration" "compliance_evidence" {
  bucket = aws_s3_bucket.compliance_evidence.id

  rule {
    default_retention {
      mode  = "GOVERNANCE"    # GOVERNANCE allows admin override; COMPLIANCE does not
      years = 7               # Retain for 7 years (PCI DSS requirement)
    }
  }
}

resource "aws_s3_bucket_versioning" "compliance_evidence" {
  bucket = aws_s3_bucket.compliance_evidence.id
  versioning_configuration {
    status = "Enabled"    # Required for Object Lock
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "compliance_evidence" {
  bucket = aws_s3_bucket.compliance_evidence.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.compliance_evidence.arn
    }
  }
}
