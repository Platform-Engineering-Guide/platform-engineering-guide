# Verify image signature before deployment
cosign verify \
  --certificate-oidc-issuer=https://token.actions.githubusercontent.com \
  --certificate-identity-regexp="https://github.com/acme-corp/payments-service/.github/workflows/build.yaml@refs/heads/main" \
  123456789.dkr.ecr.eu-west-1.amazonaws.com/payments-service@sha256:e3b0c44298...

# Verify provenance attestation
cosign verify-attestation \
  --type slsaprovenance \
  --certificate-oidc-issuer=https://token.actions.githubusercontent.com \
  --certificate-identity="https://github.com/slsa-framework/slsa-github-generator/.github/workflows/generator_container_slsa3.yml@refs/tags/v2.0.0" \
  123456789.dkr.ecr.eu-west-1.amazonaws.com/payments-service@sha256:e3b0c44298...
