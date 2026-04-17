
# PADR-001: GitOps Tooling Selection

Accepted

We need a GitOps operator to manage continuous delivery to our
Kubernetes clusters. We are running three clusters (dev, staging,
production) across two AWS accounts, with approximately 40 services
deployed.

1. Argo CD — feature-rich, strong UI, ApplicationSet support for
   multi-cluster, active community
2. Flux — lighter weight, stronger GitOps purity, good Helm support,
   active community
3. Rancher Fleet — good multi-cluster support but tighter coupling
   to Rancher ecosystem

Argo CD, primarily for its ApplicationSet support and the strength
of its UI for developer-facing deployment visibility.

- We accept the higher resource overhead of Argo CD vs Flux
- We will need to manage Argo CD HA configuration for production
  reliability
- The UI provides a useful developer-facing deployment dashboard
  without additional tooling
- Revisit if multi-cluster complexity grows beyond ~10 clusters,
  at which point Fleet or a commercial multi-cluster manager may
  be warranted

2026-01

Platform Engineering Team
