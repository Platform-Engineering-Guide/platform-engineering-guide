# Platform Engineering Maturity Model

## Overview and Framework Guide

**Version:** 1.0 — 2026 Edition  
**Scope:** Internal Developer Platforms, Platform Teams, Cloud-Native Infrastructure  
**Audience:** Platform Engineering Leads, CTOs, Engineering Directors, Platform PMs

---

## Purpose

This maturity model gives platform teams an honest, structured framework for assessing where they are, identifying the highest-leverage gaps, and sequencing improvements in a way that delivers compounding value rather than chasing completeness.

It is deliberately opinionated. Maturity models that try to accommodate every organisational context end up saying nothing useful. This one is grounded in patterns observed across high-performing platform teams in 2026 and makes explicit trade-offs visible.

**What this model is not:** A checklist to satisfy auditors. A benchmark for bragging rights. A mandate to implement every capability before moving to the next level. Organisations move through levels non-uniformly — a team can be at Level 4 in CI/CD and Level 1 in cost visibility simultaneously. The model helps you see that clearly and make deliberate choices.

---

## Model Architecture

The model spans **seven levels (0–6)** across **eight capability domains**. Each level represents a qualitatively different relationship between the platform team and its consumers — not just more tooling, but a different operating model.

### The Seven Levels

| Level | Name | Defining Characteristic |
|-------|------|--------------------------|
| 0 | Fragmented Infrastructure | No shared platform; every team does its own thing |
| 1 | Standardised Tooling | Common tools mandated, but not yet integrated |
| 2 | CI/CD Automation | Repeatable delivery pipelines; still high operator involvement |
| 3 | Platform Foundations | Core IDP exists; self-service emerging for common paths |
| 4 | Self-Service Platform | Developers provision and operate without platform team involvement |
| 5 | Platform as Product | Platform is treated as an internal product with roadmap, SLAs, NPS |
| 6 | Autonomous Platform | AI-augmented operations; platform evolves and remediates with minimal human intervention |

### The Eight Capability Domains

Assessment occurs across eight domains. No domain is optional — gaps in any one domain create ceiling effects on overall maturity.

| Domain | What It Covers |
|--------|----------------|
| **D1 — Infrastructure & Provisioning** | IaC, environment vending, cloud account management |
| **D2 — Delivery & Deployment** | CI/CD pipelines, progressive delivery, release management |
| **D3 — Developer Experience** | Portal, scaffolding, inner loop, documentation |
| **D4 — Observability** | Metrics, logs, traces, SLOs, alerting |
| **D5 — Security & Compliance** | Supply chain, runtime security, policy-as-code, secrets |
| **D6 — FinOps & Cost Management** | Cost visibility, chargeback, rightsizing, optimisation |
| **D7 — Organisational Model** | Team topology, product management, feedback loops |
| **D8 — AI & Automation** | AI-assisted tooling, autonomous operations, agentic patterns |

---

## How to Use This Model

### Step 1: Complete the Assessment Questionnaire

The `assessment-questionnaire.md` contains 80 questions across the eight domains. Each question maps to a level threshold. Answer honestly — the model is only useful if it reflects reality, not aspiration.

### Step 2: Score Each Domain

Transfer your answers to the `maturity-scorecard.xlsx`. The scorecard calculates a weighted score per domain and surfaces your current level per domain alongside a composite maturity score.

### Step 3: Identify Your Ceiling Constraints

The scorecard highlights "ceiling constraints" — capabilities that are preventing you from advancing in multiple domains simultaneously. These are typically the highest-leverage interventions.

### Step 4: Use the Improvement Roadmap Template

The `improvement-roadmap-template.md` provides a structured framework for sequencing improvements. It includes a 90-day, 6-month, and 12-month planning horizon with worked examples.

### Step 5: Reassess Quarterly

Maturity assessments lose validity quickly in active platform teams. Quarterly reassessment is the recommended cadence. The scorecard tracks historical scores to show trajectory, which is often more important than absolute position.

---

## Level Progression: Realistic Timelines

These are observed ranges, not guarantees. Teams with dedicated platform engineering headcount and executive sponsorship move faster. Teams doing platform work as a side function of infrastructure ops move slower.

| Transition | Typical Duration | Critical Enabler |
|------------|-----------------|------------------|
| 0 → 1 | 3–6 months | Leadership mandate and tooling budget |
| 1 → 2 | 6–12 months | Dedicated platform team (minimum 2–3 engineers) |
| 2 → 3 | 9–18 months | Product thinking adoption; portal investment |
| 3 → 4 | 12–24 months | Self-service culture change; golden path investment |
| 4 → 5 | 12–18 months | Platform PM hire; SLA commitment; NPS programme |
| 5 → 6 | 18–36 months | AI/ML capability; autonomous operations investment |

**The most common stall points are at Level 2→3 and Level 4→5.** Level 2→3 stalls because teams mistake "we have pipelines" for "we have a platform" — the missing ingredient is usually the developer portal and self-service infrastructure. Level 4→5 stalls because treating a platform as a product requires organisational changes (hiring a PM, establishing SLAs, running an NPS programme) that are politically difficult to secure.

---

## Scoring Philosophy

The model uses a **domain-weighted composite score** rather than a simple average. The weightings reflect the relative impact of each domain on developer productivity and platform value delivery:

| Domain | Weight |
|--------|--------|
| D1 — Infrastructure & Provisioning | 15% |
| D2 — Delivery & Deployment | 15% |
| D3 — Developer Experience | 20% |
| D4 — Observability | 12% |
| D5 — Security & Compliance | 12% |
| D6 — FinOps & Cost Management | 8% |
| D7 — Organisational Model | 13% |
| D8 — AI & Automation | 5% |

Developer Experience carries the highest weight because it is the primary interface between the platform and its consumers. A technically excellent platform that developers resist using has delivered no value.

AI & Automation carries a lower weight in 2026 because the tooling and practices are still maturing. This weighting will increase in future editions as autonomous platform operations become a baseline expectation rather than a differentiator.

---

## Anti-Patterns to Watch

**Level inflation:** Teams self-assessing at Level 4 when honest evaluation places them at Level 2 is common. The primary symptom is describing planned or in-progress capabilities as current ones. The questionnaire is designed to catch this by asking for evidence, not intent.

**Domain obsession:** Teams that advance one domain to Level 6 while neglecting others create brittle platforms. A Level 6 observability stack on a Level 1 provisioning capability is not a Level 6 platform — it is a team that has spent its budget in the wrong place.

**Maturity as a destination:** The model exists to help you make better sequencing decisions, not to reach Level 6. Many organisations operate excellent, high-value platforms at Level 4 or 5 that are genuinely right-sized for their context. Level 6 autonomous operations requires significant investment and is not appropriate for all organisations.

**Skipping organisational change:** Technical capability can be acquired faster than organisational change. The Level 4→5 transition in particular requires changes to how the platform team is funded, staffed, and accountable. Teams that skip this end up with self-service tooling that nobody trusts because there are no SLAs and no clear ownership.

---

## Relationship to Other Frameworks

This model complements but does not replace:

- **DORA Metrics** — DORA measures software delivery performance outcomes. This model assesses the platform capabilities that enable those outcomes.
- **Team Topologies** — Team Topologies describes organisational structure. This model describes what a platform team should be building and how it matures.
- **FinOps Foundation Maturity Model** — The FinOps Foundation model covers cloud cost management in depth. Domain 6 of this model is intentionally aligned with their Crawl/Walk/Run framework.
- **CNCF Landscape** — The CNCF landscape describes the tool ecosystem. This model is tool-agnostic and focuses on capability outcomes rather than specific implementations.

---

## Version and Maintenance

This model reflects the platform engineering landscape as of early 2026. It will be revised annually. The primary areas expected to evolve are Domain 8 (AI & Automation) as agentic platform operations mature, and Domain 5 (Security & Compliance) as supply chain security requirements continue to tighten.

Feedback and observed patterns from practitioners are incorporated into annual revisions. The model is a living document.
