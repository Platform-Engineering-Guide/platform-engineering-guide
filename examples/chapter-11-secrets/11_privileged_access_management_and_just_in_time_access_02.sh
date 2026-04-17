# Request elevated access for a specific incident
tsh request create \
  --roles production-emergency-access \
  --reason "INCIDENT-1234: Payments service OOM loop, need to investigate pod state"

# Approved by on-call lead through Teleport UI or CLI
# Access granted automatically, time-limited to 1 hour
# All activity during the session recorded in audit log
# Access revoked automatically at expiry
