# Generate SBOM with Syft and attach to image
syft scan \
  123456789.dkr.ecr.eu-west-1.amazonaws.com/payments-service@$IMAGE_DIGEST \
  --output spdx-json \
  --file sbom.spdx.json

cosign attest \
  --predicate sbom.spdx.json \
  --type spdxjson \
  123456789.dkr.ecr.eu-west-1.amazonaws.com/payments-service@$IMAGE_DIGEST

# Generate and attach SLSA provenance
cosign attest \
  --predicate provenance.json \
  --type slsaprovenance \
  123456789.dkr.ecr.eu-west-1.amazonaws.com/payments-service@$IMAGE_DIGEST
