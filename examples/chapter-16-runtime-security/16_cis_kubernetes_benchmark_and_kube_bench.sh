# Run kube-bench against the cluster
# Typically run as a Kubernetes Job post-cluster-provisioning
kubectl apply -f https://raw.githubusercontent.com/aquasecurity/kube-bench/main/job.yaml

# View results
kubectl logs job/kube-bench

# Example output:
# [PASS] 1.1.1 Ensure that the API server pod specification file permissions are set to 600 or more restrictive
# [FAIL] 1.2.1 Ensure that the --anonymous-auth argument is set to false
# [WARN] 1.2.2 Ensure that the --token-auth-file parameter is not set
# [PASS] 1.2.6 Ensure that the --kubelet-certificate-authority argument is set as appropriate

# Summary:
# 42 checks PASS
# 12 checks FAIL
# 11 checks WARN
