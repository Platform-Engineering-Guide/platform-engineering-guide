# Platform Engineering Maturity Model — Capability Levels

**Reference document:** Detailed capability descriptions for all seven levels across all eight domains.

---

## Level 0 — Fragmented Infrastructure

**Defining characteristic:** There is no shared platform. Each team manages its own infrastructure independently. There is no common tooling, no shared delivery mechanism, and no visibility across teams. The word "platform" may be used informally, but it describes nothing coherent.

**What you typically see:**

- Snowflake servers and hand-crafted deployments; little or no IaC
- CI/CD varies by team: some teams use GitHub Actions, others Jenkins from 2017, some deploy manually via SSH
- Secrets scattered across `.env` files, team wikis, and Slack messages
- No central logging or metrics aggregation; each team uses (or doesn't use) whatever they chose
- Cloud costs are a single bill that nobody can attribute to a team or service
- Security is someone else's problem — usually surfaced only after an incident
- Onboarding a new engineer takes weeks and depends heavily on tribal knowledge

**Organisational signal:** Infrastructure work is done by whoever is available. There is no platform team. SRE may exist as a function but is firefighting, not building. The concept of "developer experience" is not in anyone's job description.

**Common causes:** Rapid growth that outpaced investment in shared infrastructure; acquisitions; organisations where engineering grew from a single product team without platform discipline.

**Risk profile:** Very high. Security incidents, compliance failures, and outages are common and often invisible until they are severe. Cost overruns are structurally invisible. Engineer onboarding is slow and attrition-inducing.

---

## Level 1 — Standardised Tooling

**Defining characteristic:** The organisation has made deliberate decisions about which tools to use and begun enforcing those decisions. A common CI/CD platform has been selected. Cloud accounts are managed centrally. There is a beginning of shared conventions, even if adoption is incomplete.

**What you typically see:**

**D1 — Infrastructure & Provisioning**

- IaC exists but is inconsistently used; Terraform or similar is the declared standard but manual provisioning still happens
- Cloud accounts are centrally managed with basic tagging policies
- Environments are inconsistently replicated between development, staging, and production

**D2 — Delivery & Deployment**

- A single CI/CD platform is mandated (GitHub Actions, GitLab CI, or similar)
- Pipelines exist for most services but are written and maintained individually by each team
- Deployment is automated to some extent but release processes are inconsistent
- No progressive delivery; all deployments are big-bang

**D3 — Developer Experience**

- No developer portal; documentation lives in Confluence or Notion with variable quality
- Onboarding is documented but documentation is frequently stale
- Tool installation is manual; README-driven setup is the norm

**D4 — Observability**

- Basic metrics (CPU, memory, uptime) are available centrally
- Logging is centralised but unstructured and inconsistently shipped
- No distributed tracing
- Alerting is ad hoc and alert fatigue is common

**D5 — Security & Compliance**

- Secrets management is inconsistent; some secrets are still in code or config files
- Basic IAM policies exist but are often overly permissive
- No automated security scanning in pipelines
- Vulnerability management is reactive

**D6 — FinOps & Cost Management**

- Cloud costs are visible at account level but not at team or service level
- No chargeback or showback; cost is a shared concern that nobody owns
- Rightsizing is not practised

**D7 — Organisational Model**

- A platform or infrastructure team may exist but is primarily reactive operations
- No product management for platform capabilities
- No formal developer feedback mechanism

**D8 — AI & Automation**

- AI coding assistants may be in use by individual engineers without policy or governance
- No platform-level AI tooling

**Organisational signal:** The platform team (if named) spends most of its time on tickets — "provision me an S3 bucket", "give me access to X". There is significant toil on both sides of the relationship.

---

## Level 2 — CI/CD Automation

**Defining characteristic:** Delivery is automated and reliable for most services. The platform team has moved from individual requests to shared pipeline templates. Infrastructure provisioning is consistently IaC-driven. The foundations for a real platform exist, but the self-service model is not yet in place.

**What you typically see:**

**D1 — Infrastructure & Provisioning**

- IaC is standard practice; Terraform modules or Crossplane compositions exist for common resource types
- Module library is maintained centrally; teams consume approved modules
- Environment provisioning is scripted but still requires platform team involvement for new environments
- GitOps for infrastructure is being adopted or recently adopted

**D2 — Delivery & Deployment**

- Reusable pipeline templates are available and widely adopted
- Build, test, security scan, and deployment stages are standardised
- Environments are promoted through gates (dev → staging → prod)
- Feature flags are in use; some teams practice progressive delivery
- Deployment frequency has increased measurably since Level 1

**D3 — Developer Experience**

- No developer portal, or a basic Backstage instance with limited plugins
- Service catalogue may exist but is often out of date
- Scaffolding tools (Cookiecutter, Backstage templates) available for common service types
- Developer documentation is improving but inconsistent

**D4 — Observability**

- OpenTelemetry is being adopted or recently standardised
- Logs, metrics, and basic tracing are available for most services
- Dashboards exist but are team-created and inconsistent
- SLOs are defined for some services; alerting is still largely threshold-based

**D5 — Security & Compliance**

- Secrets management centralised (Vault, AWS Secrets Manager, or similar)
- SAST and container scanning integrated into pipelines
- RBAC is consistent; least-privilege is the goal if not fully achieved
- Dependency scanning is automated

**D6 — FinOps & Cost Management**

- Cost visibility at team level via tagging and tooling (Kubecost, OpenCost, or cloud-native tools)
- Showback reporting exists; chargeback is aspirational
- Rightsizing recommendations are available but not acted on systematically

**D7 — Organisational Model**

- Dedicated platform team with clear scope
- Team is beginning to adopt product practices (backlog, roadmap)
- Developer satisfaction surveys are run sporadically
- DORA metrics are measured for the first time

**D8 — AI & Automation**

- AI coding assistants are in use with basic organisational policy
- AI is used informally for IaC generation; no governance framework
- Some exploration of AI-assisted incident response

**Organisational signal:** The platform team is spending less time on tickets and more on building. But "building" still means "building things for teams" rather than "building things teams use themselves". The bottleneck has shifted from access to knowledge — developers still depend on the platform team to interpret and use what has been built.

---

## Level 3 — Platform Foundations

**Defining characteristic:** A genuine Internal Developer Platform exists. Developers can discover what exists, understand how to use it, and execute the most common workflows without involving the platform team. Self-service is real for golden paths. The platform team has shifted from doing to enabling.

**What you typically see:**

**D1 — Infrastructure & Provisioning**

- Environment vending is self-service for standard environments
- Crossplane or equivalent enables developers to request cloud resources through Kubernetes-native interfaces
- Account vending machine is operational for new team onboarding
- Drift detection is automated; infrastructure is reconciled continuously

**D2 — Delivery & Deployment**

- Pipeline-as-a-service: teams select a pipeline template and configure it without writing pipeline YAML
- Progressive delivery (canary, blue/green) is available and used for critical services
- Release management includes automated change gates and approval workflows
- Mean time to restore (MTTR) has improved measurably through pipeline standardisation

**D3 — Developer Experience**

- Developer portal (Backstage or commercial equivalent) is operational with:
  - Service catalogue with >80% coverage
  - Software templates for all golden paths
  - TechDocs integrated for platform documentation
  - Basic DORA metrics visible per service
- Onboarding time to first commit is measured and actively targeted
- Dev containers or remote dev environments are available

**D4 — Observability**

- Full LGTM stack or equivalent operational (Loki, Grafana, Tempo, Mimir/Prometheus)
- OpenTelemetry auto-instrumentation available as a platform primitive
- SLO framework in place with error budget tracking
- Alert routing is structured; runbooks are linked from alerts

**D5 — Security & Compliance**

- Policy-as-code enforced via Kyverno or OPA/Gatekeeper
- SLSA Level 2 achieved for most services
- SBOM generation is automated in build pipelines
- Zero-trust access to cluster resources (Teleport or Boundary) deployed

**D6 — FinOps & Cost Management**

- Chargeback or showback is operational and trusted by finance
- Cost anomaly detection is automated
- Rightsizing is practised with platform automation support
- FinOps function exists (even if embedded in platform team)

**D7 — Organisational Model**

- Platform team operates with a product manager or equivalent role
- Platform roadmap is public internally and reviewed quarterly
- Developer NPS or equivalent is measured quarterly
- Enabling team function exists for onboarding and documentation

**D8 — AI & Automation**

- AI coding assistants are governed with clear policy (approved tools, data handling)
- AI-assisted IaC review is in use (detecting drift, misconfigurations)
- Initial LLM-assisted incident response tooling is being evaluated or trialled

**Organisational signal:** The platform team can point to specific metrics showing developer productivity improvements. Developers complain about the platform (a good sign — they are engaged with it). The platform team has a roadmap that non-engineers can understand.

---

## Level 4 — Self-Service Platform

**Defining characteristic:** The platform is genuinely self-service. Developers can provision environments, deploy services, configure observability, manage secrets, and onboard new services without platform team involvement on the critical path. The platform team's primary work is improving the platform, not operating it for teams.

**What you typically see:**

**D1 — Infrastructure & Provisioning**

- All standard infrastructure types are available as self-service compositions
- New environment provisioning is fully automated: a developer submits a request via the portal and receives a working environment within minutes
- Multi-region and multi-cloud provisioning is supported through the platform abstraction
- Platform team no longer handles routine provisioning requests

**D2 — Delivery & Deployment**

- Zero-touch deployments for standard services: merge to main triggers the full pipeline including approval gates
- Progressive delivery is default for production changes above a defined blast radius threshold
- Deployment windows and change freezes are enforced by the platform, not by process
- Lead time for changes is measured in hours, not days

**D3 — Developer Experience**

- Developer portal is the entry point for all platform capabilities
- Service templates cover >95% of new service patterns
- Self-service onboarding: a new engineer can be productive on day one following documented paths
- Inner loop development time is measured; remote dev environments are the default for most teams
- Platform documentation quality is tracked and maintained as a first-class concern

**D4 — Observability**

- Observability is provisioned automatically when a service is created through the portal
- SLO templates are available and pre-configured for common service types
- Continuous profiling is available as a platform primitive
- Anomaly detection is operational with low false positive rate
- On-call handover is structured through platform tooling

**D5 — Security & Compliance**

- SLSA Level 3 achieved for production services
- Compliance controls are implemented as platform primitives (SOC 2, ISO 27001 controls are enforced, not audited after the fact)
- Vulnerability remediation SLAs are tracked through the platform
- Just-in-time access is the default; standing privilege is eliminated for most roles

**D6 — FinOps & Cost Management**

- Cost is visible in real-time per service in the developer portal
- Budget alerts are configured automatically for new services
- Automated rightsizing applies recommendations without manual intervention
- Cloud waste is tracked as a platform metric with defined targets

**D7 — Organisational Model**

- Platform is funded as a product with multi-year investment commitment
- SLAs are published and tracked; platform team is accountable for uptime and reliability
- Developer NPS trend is positive and used to drive roadmap priorities
- Stream-aligned teams interact with the platform without escalating to the platform team for routine work
- Platform team structure includes: engineers, PM, UX/DX specialist, technical writer

**D8 — AI & Automation**

- AI-assisted code review for security and quality is integrated into pipelines
- LLM-assisted incident response is operational: runbooks are surfaced automatically, context is aggregated
- AI-generated IaC is reviewed through automated governance gates before applying
- Platform usage patterns are analysed to surface improvement opportunities

**Organisational signal:** The platform team measures itself by platform adoption rates and developer NPS, not by ticket throughput. Developers advocate for the platform internally. New service onboarding is an event that takes hours, not weeks.

---

## Level 5 — Platform as Product

**Defining characteristic:** The platform is operated as a genuine internal product. It has SLAs, a published roadmap, a product team, and is treated with the same rigour as customer-facing products. The platform team obsesses over developer experience with the same intensity that a product team obsesses over customer experience.

**What you typically see:**

**D1 — Infrastructure & Provisioning**

- Platform abstractions are stable, versioned, and backward-compatible
- Breaking changes follow a deprecation cycle with migration tooling
- Infrastructure patterns from the platform are reused in >95% of services
- Platform team publishes internal case studies of provisioning efficiency gains

**D2 — Delivery & Deployment**

- Deployment frequency is not a concern — it is limited only by team appetite for change
- Deployment pipeline is a competitive capability, not a shared utility: teams choose this platform because it is demonstrably better than alternatives
- Change failure rate is tracked as a platform SLO

**D3 — Developer Experience**

- Developer portal is actively designed with UX input; user research is conducted quarterly
- Platform onboarding NPS is >50 (industry-leading)
- Time-to-first-commit for new services is under 30 minutes including environment provisioning
- Platform documentation is tested and maintained with the same rigour as product documentation

**D4 — Observability**

- Observability data is actionable: MTTR is measurably lower due to platform-provided context
- SLO compliance is tracked across all services and reported to engineering leadership
- Observability cost per service is tracked and optimised

**D5 — Security & Compliance**

- Security posture is continuously assessed and reported
- Compliance evidence is generated automatically; audit preparation time is minimal
- Security incidents are detected and contained faster due to platform-provided observability and policy enforcement

**D6 — FinOps & Cost Management**

- Cloud cost efficiency is tracked as a platform outcome metric
- FinOps practices are embedded in team workflows through platform tooling
- Cost-per-deployment and cost-per-service metrics are available and used in architectural decisions

**D7 — Organisational Model**

- Platform team has dedicated PM, UX researcher, technical writer, and developer advocates
- Internal conference or summit is held annually to share platform direction
- Platform has an internal "developer council" that feeds into roadmap prioritisation
- Platform NPS is a C-level metric

**D8 — AI & Automation**

- AI-assisted platform operations reduce toil measurably
- Autonomous incident remediation handles a defined class of incidents without human intervention
- AI usage within the platform is governed, audited, and its impact is measured

**Organisational signal:** Engineers at other organisations have heard of this platform and it has influenced hiring. The platform is cited in engineering blog posts. Internal developer satisfaction scores are high and improving. The platform team rejects requests that don't align with the product strategy.

---

## Level 6 — Autonomous Platform

**Defining characteristic:** The platform self-maintains, self-optimises, and self-remediates within defined boundaries. AI agents handle routine operations, anomaly response, and configuration optimisation. Human engineers focus on strategic capability development and boundary-setting for autonomous systems. The platform is aware of itself — it understands its own state and can reason about its own evolution.

**What you typically see:**

**D1 — Infrastructure & Provisioning**

- Infrastructure is continuously optimised by autonomous agents (rightsizing, placement, scheduling)
- Capacity planning is AI-driven with human review for major decisions
- New infrastructure patterns are proposed by the platform based on observed usage patterns

**D2 — Delivery & Deployment**

- Deployment risk assessment is AI-driven; deployment parameters are automatically adjusted based on risk score
- Rollbacks are triggered automatically based on SLO breach prediction, not threshold crossing
- Change velocity is autonomous within defined policy boundaries

**D3 — Developer Experience**

- The portal surfaces personalised guidance based on developer behaviour and context
- Documentation is auto-generated from platform state and kept continuously up to date
- Onboarding paths are personalised based on role, team, and service type

**D4 — Observability**

- Anomaly detection and root cause analysis are autonomous for the majority of incident types
- Observability data is correlated automatically across services without manual instrumentation
- Platform predicts and prevents SLO breaches rather than responding to them

**D5 — Security & Compliance**

- Threat detection and initial response are autonomous
- Policy violations are remediated automatically for low-risk cases; escalated with full context for high-risk cases
- Compliance posture is continuously assessed with automated evidence generation

**D6 — FinOps & Cost Management**

- Cloud spend is continuously optimised by autonomous agents within approved boundaries
- Cost anomalies are detected, investigated, and remediated autonomously
- Budget forecasting is AI-driven with high accuracy

**D7 — Organisational Model**

- Platform team structure evolves: fewer operational roles, more strategic and governance roles
- AI agents are first-class members of the operational model with defined scopes and audit trails
- Human oversight is focused on boundary-setting, ethics, and strategic direction

**D8 — AI & Automation**

- Autonomous agents operate within the platform with clearly defined authority scopes
- All autonomous actions are audited, explainable, and reversible
- Platform learns from its own operations and proposes improvements to its own capabilities
- MCP (Model Context Protocol) or equivalent provides structured platform API access for AI agents

**Organisational signal:** The ratio of platform engineers to platform consumers is dramatically lower than at Level 4 or 5, without sacrificing reliability or developer experience. The platform team spends most of its time on governance, strategy, and capability definition. Autonomous operations are trusted because they are auditable and bounded.

**Important caveat:** Level 6 is an active research area in 2026. Some organisations have achieved autonomous operations in specific domains (cost optimisation, incident routing, capacity scaling). Fully autonomous platform operations across all domains remains aspirational. Teams should not skip Level 5 to chase Level 6 — the organisational maturity required to govern autonomous systems safely requires the product thinking and feedback loops that Level 5 develops.

---

## Cross-Level Capability Summary

The following table provides a condensed reference across all levels and domains. Use this for rapid orientation, not as a substitute for the detailed descriptions above.

| Domain | L0 | L1 | L2 | L3 | L4 | L5 | L6 |
|--------|----|----|----|----|----|----|-----|
| **D1 Infra** | Manual snowflake | IaC declared | Modules + GitOps | Self-service environments | All resources self-service | Versioned abstractions | Autonomous optimisation |
| **D2 Delivery** | Varies by team | One platform mandated | Shared templates | Pipeline-as-service | Zero-touch deploy | Competitive capability | AI-driven risk mgmt |
| **D3 DX** | Tribal knowledge | Stale docs | Basic scaffolding | Portal + service catalogue | Portal as primary interface | UX-designed; NPS >50 | Personalised + auto-generated |
| **D4 Observability** | Ad hoc | Basic metrics | OTel adopted | Full LGTM + SLOs | Auto-provisioned per service | MTTR as platform SLO | Autonomous RCA |
| **D5 Security** | Reactive | Basic IAM | SAST + scanning | Policy-as-code | SLSA L3 + JIT | Continuous posture | Autonomous remediation |
| **D6 FinOps** | Invisible | Account level | Team level | Chargeback live | Real-time per service | Cost as design constraint | Autonomous optimisation |
| **D7 Org** | No team | Ops team | Dedicated platform | PM + roadmap | Full product team | C-level metric | Strategic + governance |
| **D8 AI** | None | Ad hoc copilots | Governed copilots | AI IaC review | AI incident response | AI toil reduction | Autonomous agents |
