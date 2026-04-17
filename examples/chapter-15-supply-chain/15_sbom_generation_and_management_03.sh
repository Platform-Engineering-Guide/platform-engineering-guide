# Scan container image for vulnerabilities
grype \
  123456789.dkr.ecr.eu-west-1.amazonaws.com/payments-service:v2.3.1 \
  --output table \
  --fail-on high    # Fail if HIGH or CRITICAL vulnerabilities found

# Scan an existing SBOM file
grype sbom:payments-service-sbom.cyclonedx.json \
  --output sarif \
  --file grype-results.sarif

# Typical output:
# NAME             INSTALLED  FIXED-IN  TYPE          VULNERABILITY   SEVERITY
# openssl          3.0.2      3.0.7     deb           CVE-2022-3786   Critical
# jackson-databind 2.13.0     2.13.4.2  java-archive  CVE-2022-42003  High
