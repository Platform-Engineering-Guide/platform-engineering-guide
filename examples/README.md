# The Comprehensive Guide to Platform Engineering — Code Examples

This repository contains the code examples from:
**The Comprehensive Guide to Platform Engineering — 2026 Edition**  
by Jordan Dinsdale.

## Structure

Examples are organised by chapter.

```text
examples/
├── chapter-04-idp
├── chapter-05-dev-portals
├── chapter-06-iac                          # Terraform, OpenTofu, Pulumi, Crossplane
├── chapter-07-container-orchestration
├── chapter-08-gitops                       # Argo CD, Flux CD configurations
├── chapter-09-ci-golden-path
├── chapter-10-developer-environment
├── chapter-11-secrets                      # Vault, OpenBao, External Secrets Operator
├── chapter-12-observability-strategy
├── chapter-13-observability-tooling
├── chapter-14-slos                         # Sloth, Pyrra, Alertmanager rules
├── chapter-15-supply-chain                 # Sigstore, SLSA, SBOM generation
├── chapter-16-runtime-security             # Kyverno, Falco, Tetragon policies
├── chapter-17-compliance
├── chapter-18-finops
├── chapter-19-roi
├── chapter-20-ai-platform                  # AI governance, .cursorrules, pre-commit hooks
├── chapter-21-aiml
├── chapter-22-agenticai
├── chapter-23-team-topologies
├── chapter-24-adoption-devex
├── chapter-25-roadmaps-maturity
├── chapter-26-reference-architecture-aws
├── chapter-27-reference-architecture-gcp
├── chapter-28-reference-architecture-azure
├── chapter-29-reference-architecture-multi-cloud-hybrid
├── chapter-30-case-studies
```

## Important Notes

**These examples reflect early 2026 tool versions.** Platform engineering tooling evolves quickly. Before applying any example to a production environment, verify the configuration against the current documentation for the relevant tool.

Where a tool referenced in an example has released a breaking change that affects the example's correctness, this will be noted in the relevant chapter directory's README and logged in the errata repository.

**Examples are illustrative, not production-ready.** They are designed to demonstrate the patterns described in the book. They will require adaptation to your organisation's specific environment, naming conventions, and security requirements before use in production.

## Prerequisites

Most examples assume:

- A working Kubernetes cluster (local via kind or k3d, or managed)
- kubectl configured against your target cluster
- Helm 3.x installed
- Specific tool prerequisites are listed in each chapter directory

## Versioning

This repository is tagged to align with book editions:

| Tag         | Edition            |
|-------------|--------------------|
| `v2026.1.0` | 2026 First Edition |

If you are using the 2026 edition of the book, check out the `v2026` tag to ensure the examples match the text.

## Corrections

If an example contains an error or has been superseded by a breaking tool change, please follow the contribution process at [CONTRIBUTING.md](../contributions/CONTRIBUTING.md).

## Get the Book

Available at [https://platformengineringguide.com](https://platformengineringguide.com)
