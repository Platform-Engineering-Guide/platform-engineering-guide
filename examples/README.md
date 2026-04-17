# The Comprehensive Guide to Platform Engineering — Code Examples

This repository contains the code examples from:
**The Comprehensive Guide to Platform Engineering — 2026 Edition**  
by Jordan Dinsdale.

## Structure

Examples are organised by chapter. Each directory contains a README explaining the context, prerequisites, and how to run or apply the examples.

```text
examples/
├── chapter-06-iac/          # Terraform, OpenTofu, Pulumi, Crossplane
├── chapter-08-gitops/       # Argo CD, Flux CD configurations
├── chapter-11-secrets/      # Vault, OpenBao, External Secrets Operator
├── chapter-14-slos/         # Sloth, Pyrra, Alertmanager rules
├── chapter-15-supply-chain/ # Sigstore, SLSA, SBOM generation
├── chapter-16-runtime/      # Kyverno, Falco, Tetragon policies
└── chapter-20-ai-platform/  # AI governance, .cursorrules, pre-commit hooks
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
