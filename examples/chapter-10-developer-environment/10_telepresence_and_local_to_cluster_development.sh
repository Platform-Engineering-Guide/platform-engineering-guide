# Connect to the cluster — establishes the network tunnel
telepresence connect

# Now cluster services are accessible locally
curl http://orders-service.orders.svc.cluster.local/health
# Returns the cluster orders-service health response

# Intercept traffic to the payments-service deployment
# Route cluster traffic for payments-service to the local process
telepresence intercept payments-service \
  --port 8080:8080 \
  --env-file .env.cluster

# The locally running payments-service now receives traffic
# from the cluster, including from other services and ingress
