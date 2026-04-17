#!/bin/bash
# dev-start.sh — Start local development connected to staging cluster

# Connect to staging cluster
telepresence connect --context staging-cluster

# Fetch development secrets
platform secrets pull --service payments-service --env staging --output .env.local

# Start local dependencies not available in the cluster (if any)
docker-compose up -d wiremock

# Intercept cluster traffic
telepresence intercept payments-service \
  --port 8080 \
  --env-file .env.cluster \
  --replace  # Replace cluster service with local version

# Merge environment files
cat .env.cluster .env.local > .env.merged

# Start the local service with merged environment
source .env.merged
mvn spring-boot:run

# On exit, clean up the intercept
# (telepresence intercept leave happens automatically on process termination)
