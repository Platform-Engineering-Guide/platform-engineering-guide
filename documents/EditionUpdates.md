# Edition Update Protocol

The following protocol governs the preparation of each new edition. It is documented here so that the update process is reproducible by any future editorial team working on this book, regardless of who was involved in prior editions.

## Phase 1 — Version Audit (first week of edition cycle)

The manuscript source is a Markdown repository. All inline version strings follow the convention of appearing in backtick code formatting. The audit command is:

```bash
grep -rn '`v[0-9]\+\.[0-9][0-9]*\.' manuscript/
grep -rn '`[0-9]\+\.[0-9][0-9]*\.' manuscript/
```

The output of this audit is a working document listing every version string, the chapter and section it appears in, and the current version as of the edition date. This working document drives the Tool Versions Appendix update.

## Phase 2 — High-Churn Chapters (weeks 2–4)

Chapters are reviewed in this order, reflecting their rate of change:

*Chapter 22 (Agentic AI):* This chapter has the highest probability of requiring substantial revision. The agentic AI space in early 2026 is moving faster than any other section of the book. Review the entire chapter against current practice, community resources (CNCF TAG App Delivery, LangChain, Anthropic, OpenAI developer documentation), and production deployment patterns reported at KubeCon and PlatformCon since the previous edition.

*Chapter 21 (AI/ML Platforms):* GPU tooling, model serving frameworks, and LLMOps patterns are all subject to meaningful revision cadences. vLLM, KServe, and Ray Serve release significant changes on quarterly timescales.

*Chapters 26–28 (Reference Architectures):* Configuration examples contain the highest concentration of version-specific content. Every `apiVersion`, image tag, and Helm chart version reference should be validated against current releases.

*Chapters 7–8 (Kubernetes, GitOps):* Kubernetes releases three minor versions per year. Managed service capabilities (EKS, GKE, AKS) change continuously. Argo CD and Flux both release on monthly or faster cadences.

*Chapters 15–17 (Security):* The Sigstore ecosystem, OPA/Gatekeeper policy API versions, and Kyverno policy syntax all change. SLSA specification versions are stable but implementation tooling is not.

## Phase 3 — Structural Chapters (final review)

Chapters on team topologies, platform maturity models, developer experience measurement, FinOps principles, and organisational patterns change slowly. A targeted review for new research findings (updated DORA report, new DX Core 4 data, revised FinOps Foundation framework) and any community consensus shifts is sufficient.

## Phase 4 — Changelog and Front Matter

Update the Edition Changelog table in the "About This Edition" section. Every chapter with material changes should appear in the table. A chapter that required only version number updates (no conceptual or recommendation changes) can be noted as "Version updates only." A chapter with recommendation changes should summarise what changed and why.
