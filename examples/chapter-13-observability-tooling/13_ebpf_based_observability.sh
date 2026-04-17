# Hubble CLI — network observability from the command line

# Watch all HTTP flows in the payments namespace
hubble observe --namespace payments --protocol http --follow

# Output:
# TIMESTAMP         SOURCE                                DESTINATION                          TYPE    VERDICT
# 2026-01-15 14:32  payments/payments-service-7d8f9b      payments/postgres-0:5432             TCP     FORWARDED
# 2026-01-15 14:32  payments/payments-service-7d8f9b      external/stripe.com:443              HTTP    FORWARDED
# 2026-01-15 14:32  orders/orders-service-4c6f8d          payments/payments-service-7d8f9b:80  HTTP    FORWARDED

# Find all DNS queries from the payments namespace
hubble observe --namespace payments --protocol dns --follow

# Summarise top connections by source/destination
hubble observe --namespace payments --output json \
  | jq -r '[.source.namespace, .source.pod_name, .destination.namespace, .destination.pod_name] | @tsv' \
  | sort | uniq -c | sort -rn | head -20
