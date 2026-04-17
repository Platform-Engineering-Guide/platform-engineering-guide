# terraform/org-policies/main.tf — critical security organisation policies

# Require OS Login for all Compute Engine instances
resource "google_org_policy_policy" "require_os_login" {
  name   = "organizations/${var.org_id}/policies/compute.requireOsLogin"
  parent = "organizations/${var.org_id}"
  spec {
    rules {
      enforce = true
    }
  }
}

# Disable serial port access — prevents console-based access to VMs
resource "google_org_policy_policy" "disable_serial_port" {
  name   = "organizations/${var.org_id}/policies/compute.disableSerialPortAccess"
  parent = "organizations/${var.org_id}"
  spec {
    rules {
      enforce = true
    }
  }
}

# Restrict public IP addresses — all GKE nodes must be private
resource "google_org_policy_policy" "restrict_public_ip" {
  name   = "organizations/${var.org_id}/policies/compute.vmExternalIpAccess"
  parent = "organizations/${var.org_id}"
  spec {
    rules {
      deny_all = true
    }
  }
}

# Restrict cloud storage bucket public access
resource "google_org_policy_policy" "restrict_public_gcs" {
  name   = "organizations/${var.org_id}/policies/storage.publicAccessPrevention"
  parent = "organizations/${var.org_id}"
  spec {
    rules {
      enforce = true
    }
  }
}

# Uniform bucket-level access — prevent per-object ACLs
resource "google_org_policy_policy" "require_uniform_bucket_access" {
  name   = "organizations/${var.org_id}/policies/storage.uniformBucketLevelAccess"
  parent = "organizations/${var.org_id}"
  spec {
    rules {
      enforce = true
    }
  }
}

# Restrict allowed locations — data residency enforcement
resource "google_org_policy_policy" "restrict_resource_locations" {
  name   = "organizations/${var.org_id}/policies/gcp.resourceLocations"
  parent = "organizations/${var.org_id}"
  spec {
    rules {
      values {
        allowed_values = [
          "in:europe-locations",
          "in:us-locations",
        ]
      }
    }
  }
}
