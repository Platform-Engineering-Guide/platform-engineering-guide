# Generate CycloneDX SBOM for a container image
syft scan \
  123456789.dkr.ecr.eu-west-1.amazonaws.com/payments-service:v2.3.1 \
  --output cyclonedx-json \
  --file payments-service-sbom.cyclonedx.json

# Generate SPDX SBOM for a source directory
syft scan \
  dir:./src \
  --output spdx-json \
  --file payments-service-src-sbom.spdx.json

# Typical SBOM output for a Java service includes:
# - JVM and base OS packages
# - Maven dependencies (direct and transitive)
# - System libraries in the container
# - Build tool versions
