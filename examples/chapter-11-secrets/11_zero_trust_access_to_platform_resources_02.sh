# Developer workflow with Teleport
# Login with SSO (GitHub, Google, Okta, etc.)
tsh login --proxy=teleport.acme.io --auth=okta

# List available clusters
tsh kube ls

# Switch to production cluster (MFA prompt triggered)
tsh kube login production-eu-west-1

# kubectl now works through the Teleport proxy
kubectl get pods -n payments

# All commands are recorded in Teleport's audit log
