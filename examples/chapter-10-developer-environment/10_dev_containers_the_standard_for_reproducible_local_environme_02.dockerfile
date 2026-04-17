# Platform base dev container image
# Maintained by the platform team
FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04

# Install platform-standard tool versions
ARG KUBECTL_VERSION=1.30.0
ARG HELM_VERSION=3.15.0
ARG KUSTOMIZE_VERSION=5.4.0
ARG ARGOCD_CLI_VERSION=2.11.0
ARG OPENTOFU_VERSION=1.7.0

RUN curl -LO "https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
    && rm kubectl

RUN curl -fsSL "https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz" \
    | tar -xz && mv linux-amd64/helm /usr/local/bin/helm

# Install internal CA certificate for corporate proxy
COPY certs/internal-ca.crt /usr/local/share/ca-certificates/internal-ca.crt
RUN update-ca-certificates

# Configure platform CLI defaults
COPY config/platform-cli-config.yaml /etc/platform/config.yaml

# Install platform CLI
RUN curl -fsSL https://platform.internal.acme.io/cli/install.sh | sh

# Configure git defaults
RUN git config --system core.autocrlf input \
    && git config --system pull.rebase true

LABEL org.opencontainers.image.source="https://github.com/acme-corp/platform-devcontainer"
LABEL org.opencontainers.image.version="${BUILD_VERSION}"
