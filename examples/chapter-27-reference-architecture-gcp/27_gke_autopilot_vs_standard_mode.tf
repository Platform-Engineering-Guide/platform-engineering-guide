# terraform/modules/gke-autopilot/main.tf — workload cluster
resource "google_container_cluster" "workload" {
  name     = var.cluster_name
  location = var.region          # Regional cluster for HA control plane

  # Autopilot mode
  enable_autopilot = true

  # Private cluster — no public node IPs
  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false   # Public endpoint, restricted via master_authorized_networks
    master_ipv4_cidr_block  = var.master_cidr
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = var.corporate_cidr
      display_name = "Corporate network"
    }
  }

  # Shared VPC configuration
  network    = "projects/${var.host_project}/global/networks/platform-vpc"
  subnetwork = "projects/${var.host_project}/regions/${var.region}/subnetworks/${var.subnet_name}"

  ip_allocation_policy {
    cluster_secondary_range_name  = "${var.subnet_name}-pods"
    services_secondary_range_name = "${var.subnet_name}-services"
  }

  # Workload Identity — replaces service account key files for GCP API access
  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  # Binary authorisation — only approved images can run
  binary_authorization {
    evaluation_mode = "PROJECT_SINGLETON_POLICY_ENFORCE"
  }

  # Release channel — REGULAR provides stable Kubernetes versions with managed upgrades
  release_channel {
    channel = "REGULAR"
  }

  maintenance_policy {
    recurring_window {
      start_time = "2024-01-01T02:00:00Z"
      end_time   = "2024-01-01T06:00:00Z"
      recurrence = "FREQ=WEEKLY;BYDAY=SA,SU"
    }
  }

  resource_labels = {
    environment = var.environment
    managed-by  = "terraform"
    team        = "platform"
  }
}
