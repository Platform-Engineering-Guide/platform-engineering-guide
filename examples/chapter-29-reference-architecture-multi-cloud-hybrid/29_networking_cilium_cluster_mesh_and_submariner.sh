# Enable Cluster Mesh between two clusters
# Assumes Cilium is installed on both clusters with non-overlapping CIDRs

# On cluster 1 (AWS)
cilium clustermesh enable \
  --service-type LoadBalancer \
  --create-ca

# On cluster 2 (GCP)
cilium clustermesh enable \
  --service-type LoadBalancer

# Connect the clusters
cilium clustermesh connect \
  --destination-context gke_workloads-production_europe-west1_production-gcp

# Verify connection
cilium clustermesh status
