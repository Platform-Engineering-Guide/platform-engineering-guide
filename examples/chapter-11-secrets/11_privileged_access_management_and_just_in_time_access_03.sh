# Generate dynamic database credentials for a maintenance task
vault read database/creds/payments-admin-role

# Output:
# Key                Value
# ---                -----
# lease_id           database/creds/payments-admin-role/abc123
# lease_duration     1h
# lease_renewable    true
# password           A1a-RandomlyGeneratedPassword
# username           v-token-payments-admin-1234567890

# After maintenance, revoke the credential immediately
vault lease revoke database/creds/payments-admin-role/abc123
