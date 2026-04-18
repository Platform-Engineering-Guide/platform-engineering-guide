# Platform Engineering Maturity Assessment Questionnaire

**Version:** 1.0 — 2026 Edition  
**Estimated completion time:** 60–90 minutes  
**Recommended participants:** Platform engineering lead, senior platform engineers, engineering manager or director

---

## Instructions

Answer each question based on the **current state** of your platform — not what is in progress, not what is planned. If a capability exists for some teams but not others, estimate the percentage coverage and answer conservatively.

For each question, select the response that most accurately describes your organisation today. Transfer your answers to the `maturity-scorecard.xlsx` to calculate your domain scores and composite maturity level.

**Honest answers produce useful results. Optimistic answers produce flattering scores that help nobody.**

---

## Domain 1 — Infrastructure & Provisioning (D1)

**D1-Q1. How is infrastructure provisioned in your organisation?**

- [ ] A — Primarily manual: engineers SSH into servers or click through cloud consoles to provision resources
- [ ] B — IaC exists but is inconsistently used; some teams use Terraform or CloudFormation, others do not
- [ ] C — IaC is the declared standard; most resources are managed through code, but coverage is incomplete
- [ ] D — IaC is comprehensive and enforced; manual provisioning is an exception that triggers a review
- [ ] E — Infrastructure is self-service: developers request resources through the platform and they are provisioned automatically without platform team involvement
- [ ] F — Infrastructure provisioning is fully automated and continuously reconciled; AI agents propose and apply optimisations within defined boundaries

*Level threshold: A=0, B=1, C=2, D=3, E=4, F=6*

---

**D1-Q2. How are cloud environments (dev, staging, production) managed?**

- [ ] A — Environments are hand-crafted and differ significantly from each other; production configuration is not reproducible
- [ ] B — Environments are defined in IaC but require platform team involvement to create new ones
- [ ] C — Standard environment types can be provisioned by the platform team within hours; templates exist
- [ ] D — Developers can provision standard environments through a self-service interface without platform team involvement
- [ ] E — Environment provisioning is a portal workflow that completes in under 15 minutes including all dependencies

*Level threshold: A=0, B=1, C=2, D=3-4, E=5*

---

**D1-Q3. How is infrastructure drift managed?**

- [ ] A — Drift is not detected; manual changes accumulate undetected
- [ ] B — Drift is detected through periodic manual review or ad hoc Terraform plan output
- [ ] C — Drift detection is automated but remediation requires manual intervention
- [ ] D — Drift detection and alert is automated; remediations are proposed automatically and applied with approval
- [ ] E — Continuous reconciliation (GitOps) means drift is detected and remediated automatically within minutes

*Level threshold: A=0, B=1, C=2, D=3-4, E=5*

---

**D1-Q4. How are cloud accounts or subscriptions managed for new teams?**

- [ ] A — New accounts are created manually by a cloud administrator; takes days to weeks
- [ ] B — Account creation is semi-automated; standard policies are applied but process still requires platform team action
- [ ] C — Account vending is automated; a new account with standard guardrails can be created within hours
- [ ] D — Account vending is self-service through the developer portal or an automated workflow triggered by team creation
- [ ] E — Account vending is fully automated with continuous compliance enforcement post-creation

*Level threshold: A=0, B=1, C=2-3, D=4, E=5*

---

**D1-Q5. What is your IaC module/composition strategy?**

- [ ] A — No shared modules; each team writes its own IaC from scratch
- [ ] B — Some shared modules exist but are not maintained centrally or versioned consistently
- [ ] C — A centrally maintained module library exists; teams are expected to consume it but enforcement is inconsistent
- [ ] D — A module/composition library is maintained with semantic versioning; teams are required to use approved modules for standard resource types
- [ ] E — Platform abstractions (Crossplane compositions, Terraform modules) fully abstract cloud provider details from developers; developers work with platform-level concepts not cloud primitives

*Level threshold: A=0, B=1, C=2, D=3, E=4-5*

---

## Domain 2 — Delivery & Deployment (D2)

**D2-Q1. How do teams build and deploy their services?**

- [ ] A — Build and deploy processes vary significantly by team; no shared tooling or conventions
- [ ] B — A single CI/CD platform is mandated but each team maintains its own pipeline configuration
- [ ] C — Shared pipeline templates are available; most teams use them with team-specific customisations
- [ ] D — Pipeline-as-a-service: teams configure their pipeline through parameters, not by writing pipeline YAML; templates handle the implementation
- [ ] E — Zero-touch pipelines: standard services deploy automatically based on platform-determined risk assessment with no manual gates for low-risk changes

*Level threshold: A=0, B=1, C=2, D=3, E=4-5*

---

**D2-Q2. What is your deployment frequency for a typical production service?**

- [ ] A — Less than once per month; releases are batched and scheduled
- [ ] B — Weekly to monthly; release process requires coordination across teams
- [ ] C — Weekly or more frequently for most services; pipeline automation enables this
- [ ] D — Daily or multiple times per day; deployment is a routine, low-ceremony event
- [ ] E — On-demand, multiple times per day; deployment frequency is limited only by team preference

*Level threshold: A=0, B=1, C=2-3, D=4, E=5*

---

**D2-Q3. How are production changes governed?**

- [ ] A — No formal change management; changes are applied ad hoc
- [ ] B — Manual change approval process; change advisory board or equivalent reviews significant changes
- [ ] C — Automated change gates exist for some stages; production deployment requires manual approval
- [ ] D — Risk-based automated gates: low-risk changes deploy automatically; high-risk changes are flagged with context for human decision
- [ ] E — AI-assisted risk assessment determines deployment parameters; human review is reserved for policy-boundary decisions

*Level threshold: A=0, B=1-2, C=3, D=4, E=5-6*

---

**D2-Q4. What progressive delivery capabilities does your platform provide?**

- [ ] A — No progressive delivery; all deployments are big-bang
- [ ] B — Feature flags are available but managed manually outside the deployment pipeline
- [ ] C — Blue/green deployment is available for critical services; most services still use direct replacement
- [ ] D — Canary deployments and automated rollbacks are available as a platform primitive; teams opt in with minimal configuration
- [ ] E — Progressive delivery is the default for production changes above a defined blast radius; rollback is automated on SLO breach prediction

*Level threshold: A=0, B=1, C=2, D=3-4, E=5*

---

**D2-Q5. How do you measure and track delivery performance?**

- [ ] A — No systematic measurement of delivery performance
- [ ] B — DORA metrics are tracked informally or for some teams
- [ ] C — DORA metrics (deployment frequency, lead time, change failure rate, MTTR) are tracked for most services
- [ ] D — DORA metrics are tracked automatically through platform tooling and visible per service in the developer portal
- [ ] E — Delivery performance is tracked per service, per team, and in aggregate; used actively to drive platform investment decisions

*Level threshold: A=0, B=1, C=2-3, D=4, E=5*

---

## Domain 3 — Developer Experience (D3)

**D3-Q1. How do developers discover platform capabilities?**

- [ ] A — Word of mouth and tribal knowledge; no central resource
- [ ] B — Confluence or wiki-based documentation; often stale
- [ ] C — A developer portal or internal docs site exists but coverage is incomplete and adoption is low
- [ ] D — A developer portal (Backstage or equivalent) is the primary interface for platform capabilities; service catalogue, templates, and docs are integrated
- [ ] E — The developer portal is the single entry point for all platform capabilities including provisioning, deployment, observability, and cost; coverage is >95% of services

*Level threshold: A=0, B=1, C=2, D=3-4, E=5*

---

**D3-Q2. How long does it take a new engineer to make their first production commit?**

- [ ] A — More than 2 weeks; onboarding is heavily dependent on senior engineers' time
- [ ] B — 1–2 weeks; documentation exists but is incomplete and frequently outdated
- [ ] C — Less than 1 week; onboarding documentation is reasonably current
- [ ] D — 1–3 days; golden path documentation covers the common cases; self-service tooling enables setup without hand-holding
- [ ] E — Under 24 hours; onboarding is a documented, self-service workflow; time to first commit is actively measured and targeted

*Level threshold: A=0, B=1, C=2-3, D=4, E=5*

---

**D3-Q3. How are new services created?**

- [ ] A — Copy an existing service and modify; no standard scaffolding
- [ ] B — Some README-based templates exist; mostly manual setup
- [ ] C — Scaffolding tools (Cookiecutter, Yeoman, Backstage software templates) exist for some service types
- [ ] D — Software templates in the developer portal cover all standard service types; a new service is ready to deploy within 30 minutes of template execution
- [ ] E — Templates are continuously maintained, tested, and versioned; template coverage is measured; custom service types are rare and require justification

*Level threshold: A=0, B=1, C=2, D=3-4, E=5*

---

**D3-Q4. How do developers work locally against production-like environments?**

- [ ] A — Local development is not production-like; "it works on my machine" is a common phrase
- [ ] B — Docker Compose files exist for some services but are maintained inconsistently
- [ ] C — Dev containers or standardised local environments are available; most engineers use them
- [ ] D — Remote development environments (Coder, Gitpod, or similar) are available as a platform primitive; inner loop tools (Telepresence, Tilt) are supported
- [ ] E — Remote dev environments are provisioned automatically through the platform; environment parity with production is maintained and verified

*Level threshold: A=0, B=1, C=2-3, D=4, E=5*

---

**D3-Q5. How is developer satisfaction with the platform measured?**

- [ ] A — Not measured; feedback is informal and reactive
- [ ] B — Annual or ad hoc surveys; feedback is collected but not systematically acted on
- [ ] C — Quarterly developer satisfaction surveys; NPS or equivalent is tracked
- [ ] D — Regular NPS measurement with systematic analysis; results are directly tied to platform roadmap priorities
- [ ] E — Continuous feedback collection (portal analytics, survey pulse, community forums) combined with quarterly structured NPS; developer satisfaction is a C-level metric

*Level threshold: A=0, B=1, C=2-3, D=4, E=5*

---

## Domain 4 — Observability (D4)

**D4-Q1. What telemetry does your platform provide or require?**

- [ ] A — Each team instruments independently; no standard approach
- [ ] B — Basic metrics (infrastructure-level: CPU, memory, disk) are centralised; application metrics and logs vary
- [ ] C — OpenTelemetry or equivalent is the declared standard; most services emit structured logs and metrics; tracing adoption is partial
- [ ] D — Full three pillars (logs, metrics, traces) are available for most services; OpenTelemetry auto-instrumentation is a platform primitive
- [ ] E — Four pillars (logs, metrics, traces, profiles) are available; telemetry is provisioned automatically when a service is created

*Level threshold: A=0, B=1, C=2, D=3-4, E=5*

---

**D4-Q2. How are SLOs managed across services?**

- [ ] A — No SLOs defined
- [ ] B — SLOs are defined for some critical services; tracking is manual
- [ ] C — SLOs are defined for most services; error budgets are calculated and tracked in dashboards
- [ ] D — SLO framework with error budget alerting is a platform primitive; teams adopt it with minimal configuration; burn rate alerts replace threshold alerts
- [ ] E — SLO compliance is tracked across all services; automatically reported to engineering leadership; SLO breach prediction prevents incidents rather than responding to them

*Level threshold: A=0, B=1, C=2-3, D=4, E=5*

---

**D4-Q3. What is the average MTTR for production incidents?**

- [ ] A — Hours to days; incidents are diagnosed manually with little tooling support
- [ ] B — 1–4 hours typically; basic dashboards are available but context aggregation is manual
- [ ] C — Under 1 hour for most incidents; runbooks are linked from alerts; some automation exists
- [ ] D — Under 30 minutes for most incidents; platform provides correlated context automatically; runbook execution is partially automated
- [ ] E — Platform-level incidents are often resolved autonomously; human-facing incidents are resolved in under 15 minutes due to rich, automatically correlated context

*Level threshold: A=0, B=1, C=2-3, D=4, E=5-6*

---

**D4-Q4. How is alerting managed?**

- [ ] A — Ad hoc alerting; alert fatigue is high; many alerts are ignored
- [ ] B — Alerting is centralised but primarily threshold-based; false positive rate is high
- [ ] C — Alert routing is structured; on-call rotation is managed through PagerDuty or equivalent; runbooks are linked
- [ ] D — Symptom-based alerting (burn rates, SLO breach) rather than cause-based; alert fatigue is actively managed; noise is measured and reduced
- [ ] E — Automated alert grouping, correlation, and suppression; AI-assisted alert triage; runbook suggestions are automated

*Level threshold: A=0, B=1, C=2-3, D=4, E=5-6*

---

**D4-Q5. How is observability infrastructure managed?**

- [ ] A — No centralised observability infrastructure
- [ ] B — Basic managed services (CloudWatch, Azure Monitor) used with no standardisation
- [ ] C — Self-managed observability stack (Prometheus, Grafana, Loki, or equivalent); maintained by platform team
- [ ] D — Observability stack is treated as a platform product with SLAs; cardinality management and cost optimisation are practised
- [ ] E — Observability infrastructure is self-optimising; cardinality, retention, and cost are managed autonomously within defined bounds

*Level threshold: A=0, B=1-2, C=3, D=4-5, E=6*

---

## Domain 5 — Security & Compliance (D5)

**D5-Q1. How are secrets managed?**

- [ ] A — Secrets in code, config files, or environment variables committed to source control
- [ ] B — Secrets are mostly out of source control but stored inconsistently (team wikis, spreadsheets, ad hoc Secrets Manager usage)
- [ ] C — Central secrets management (HashiCorp Vault, AWS Secrets Manager, or equivalent) is adopted; most secrets are managed centrally
- [ ] D — Secrets injection is automated through platform primitives (External Secrets Operator, CSI driver); applications never handle raw secrets; rotation is automated for most secret types
- [ ] E — Zero-trust secret access with workload identity (SPIFFE/SPIRE, IRSA, Workload Identity Federation); all secret access is audited and anomaly-detected

*Level threshold: A=0, B=1, C=2-3, D=4, E=5*

---

**D5-Q2. How is policy enforced across platform resources?**

- [ ] A — Policy is documentation-based; enforcement relies on human compliance
- [ ] B — Some automated policy checks exist (AWS Config rules, Azure Policy) but coverage is incomplete
- [ ] C — Policy-as-code is adopted (OPA/Gatekeeper or Kyverno); admission control enforces policies on Kubernetes resources
- [ ] D — Policy library covers all standard workload types; policy violations block deployment; policy exceptions require formal approval
- [ ] E — Policy compliance is continuously assessed; policy violations are automatically remediated for low-risk cases; audit evidence is automatically generated

*Level threshold: A=0, B=1, C=2-3, D=4, E=5-6*

---

**D5-Q3. What is your software supply chain security posture?**

- [ ] A — No supply chain security practices; dependencies are not tracked systematically
- [ ] B — Basic dependency scanning exists; some vulnerability alerts are actioned
- [ ] C — SBOM generation is automated; container images are signed; SLSA Level 1 achieved for most services
- [ ] D — SLSA Level 2–3 achieved; image signing and verification enforced at deployment; SBOMs are stored and queryable
- [ ] E — Full supply chain attestation from source to production; SLSA Level 3 for all production services; automated vulnerability remediation within defined SLAs

*Level threshold: A=0, B=1, C=2-3, D=4, E=5*

---

**D5-Q4. How is access to production systems managed?**

- [ ] A — Broad standing access; most engineers have direct access to production systems
- [ ] B — RBAC exists but is coarse-grained; access reviews happen infrequently
- [ ] C — Least-privilege RBAC is practised; access reviews occur quarterly or more frequently
- [ ] D — Just-in-time access for production systems (Teleport, Boundary, or equivalent); all access is audited and time-bounded
- [ ] E — Zero standing privilege; all access is JIT with automated approval workflows; anomalous access triggers automated alerts and investigations

*Level threshold: A=0, B=1, C=2-3, D=4, E=5-6*

---

**D5-Q5. How is compliance managed?**

- [ ] A — Compliance is not systematically managed; audit preparation is a manual fire drill
- [ ] B — Compliance controls are documented but verified manually; annual audit is stressful and time-consuming
- [ ] C — Key compliance controls are automated; evidence collection is partially automated
- [ ] D — Compliance-as-code: controls are implemented as platform primitives; continuous compliance posture assessment is operational; audit evidence is auto-generated
- [ ] E — Compliance is a platform service: teams inherit compliance controls by using the platform; compliance posture is continuously reported to leadership

*Level threshold: A=0, B=1, C=2-3, D=4, E=5*

---

## Domain 6 — FinOps & Cost Management (D6)

**D6-Q1. What cloud cost visibility exists in your organisation?**

- [ ] A — Cloud cost is a single bill; attribution to teams or services is not possible
- [ ] B — Cost is visible at account or project level through cloud-native tooling; team-level attribution requires manual effort
- [ ] C — Team-level cost visibility exists through consistent tagging and FinOps tooling (Kubecost, OpenCost, CloudHealth, or equivalent)
- [ ] D — Service-level cost visibility is available in real-time; developers can see the cost of their services in the developer portal
- [ ] E — Cost is visible per service, per deployment, per request for instrumented workloads; cost is a design-time consideration with tooling support

*Level threshold: A=0, B=1, C=2-3, D=4, E=5*

---

**D6-Q2. How are cloud costs allocated to teams?**

- [ ] A — All cloud costs are treated as shared overhead; no team-level allocation
- [ ] B — Informal showback: cost reports are shared with teams periodically but there are no consequences for spending
- [ ] C — Formal showback: accurate cost reports are shared monthly; teams are expected to review and optimise
- [ ] D — Chargeback: cloud costs are allocated to team budgets and actioned; teams have incentives to optimise
- [ ] E — Real-time chargeback with budget alerts; cost governance is embedded in deployment workflows; budget overruns trigger automated alerts and optional deployment gates

*Level threshold: A=0, B=1, C=2-3, D=4, E=5*

---

**D6-Q3. How is cloud resource rightsizing managed?**

- [ ] A — Resources are never rightsized; initial sizing persists indefinitely
- [ ] B — Rightsizing is performed ad hoc when costs become visibly excessive
- [ ] C — Rightsizing recommendations are generated by tooling; teams are expected to action them but compliance is voluntary
- [ ] D — Rightsizing recommendations are prioritised and tracked; platform automation applies safe recommendations automatically (CPU and memory adjustments below defined thresholds)
- [ ] E — Continuous autonomous rightsizing within defined bounds; significant changes require human review; cost efficiency is measured as a platform outcome

*Level threshold: A=0, B=1, C=2, D=3-4, E=5-6*

---

**D6-Q4. Is there a FinOps function in your organisation?**

- [ ] A — No FinOps function; cloud cost is nobody's specific responsibility
- [ ] B — Cloud cost is owned by Finance or procurement, not Engineering; limited engineering engagement
- [ ] C — FinOps responsibility is embedded in the platform team; a FinOps practice is emerging
- [ ] D — Dedicated FinOps capability (team or function) with regular engagement across Engineering, Finance, and Product
- [ ] E — FinOps is a mature organisational capability; cost efficiency targets are agreed cross-functionally; the platform actively supports FinOps practices

*Level threshold: A=0, B=1, C=2-3, D=4, E=5*

---

**D6-Q5. How is cloud waste managed?**

- [ ] A — Cloud waste is not tracked; idle resources accumulate indefinitely
- [ ] B — Waste is identified periodically through manual review; remediation is ad hoc
- [ ] C — Automated waste detection identifies idle resources, unused reservations, and over-provisioned instances
- [ ] D — Cloud waste is tracked as a platform metric; automated remediation handles obvious cases (terminate idle dev environments after hours, downsize clearly over-provisioned resources)
- [ ] E — Autonomous waste management within defined policies; waste trends are reported and used to drive architectural decisions

*Level threshold: A=0, B=1, C=2-3, D=4, E=5-6*

---

## Domain 7 — Organisational Model (D7)

**D7-Q1. How is the platform team structured?**

- [ ] A — No distinct platform team; infrastructure work is done by whoever is available
- [ ] B — An infrastructure or ops team exists; platform work is part of their remit alongside operational responsibilities
- [ ] C — A dedicated platform engineering team exists; scope is clearly defined and distinct from operations
- [ ] D — Platform team includes engineers, a product manager (or equivalent), and a developer experience specialist
- [ ] E — Platform team is structured as a product team: PM, UX/DX researcher, engineers, technical writer, developer advocates; platform is funded as a product

*Level threshold: A=0, B=1, C=2-3, D=4, E=5*

---

**D7-Q2. How is the platform roadmap managed and communicated?**

- [ ] A — No platform roadmap; work is driven by tickets and requests
- [ ] B — An informal backlog exists; priorities are set by the platform team lead without structured input
- [ ] C — A platform roadmap exists and is reviewed quarterly; internal stakeholders have visibility
- [ ] D — Platform roadmap is publicly visible internally; reviewed quarterly with engineering leadership input; developer pain surveys inform priorities
- [ ] E — Platform roadmap is co-created with a developer council; prioritisation uses data (NPS, usage analytics, pain survey) and is transparent across the engineering organisation

*Level threshold: A=0, B=1, C=2-3, D=4, E=5*

---

**D7-Q3. How does the platform team relate to the teams it serves?**

- [ ] A — The platform team is a bottleneck; teams wait for platform team involvement to complete routine work
- [ ] B — The platform team responds to requests; interaction is primarily request/response
- [ ] C — The platform team is enabling: it builds capabilities that teams use independently; most routine work does not require platform team involvement
- [ ] D — The platform team is a product team: it obsesses over developer experience, measures it, and iterates based on data
- [ ] E — The platform team is a strategic partner: it works with stream-aligned teams to shape platform direction based on product roadmap requirements; enabling teams handle onboarding and education

*Level threshold: A=0, B=1, C=2-3, D=4, E=5*

---

**D7-Q4. What is the platform team's relationship with senior leadership?**

- [ ] A — Platform work is not visible to senior leadership; it is treated as overhead
- [ ] B — Platform team reports to engineering management; progress is communicated informally
- [ ] C — Platform engineering is recognised as a distinct function with defined success metrics
- [ ] D — Platform metrics (developer NPS, deployment frequency, MTTR, cost efficiency) are reviewed at engineering leadership level quarterly
- [ ] E — Platform engineering outcomes are C-level metrics; platform investment is justified through demonstrated ROI; platform strategy is part of engineering strategy

*Level threshold: A=0, B=1, C=2-3, D=4, E=5*

---

**D7-Q5. How is developer feedback captured and acted on?**

- [ ] A — Feedback is informal; no systematic mechanism
- [ ] B — Occasional surveys; feedback may or may not influence platform direction
- [ ] C — Quarterly developer satisfaction surveys with analysis; results are shared with the platform team
- [ ] D — Developer NPS is tracked quarterly; results directly influence roadmap; feedback themes are published internally
- [ ] E — Continuous feedback (portal analytics, community channels, pulse surveys) supplemented by quarterly structured research; developer council provides ongoing advisory input; all feedback is publicly acknowledged with disposition

*Level threshold: A=0, B=1, C=2-3, D=4, E=5*

---

## Domain 8 — AI & Automation (D8)

**D8-Q1. How are AI coding assistants managed in your organisation?**

- [ ] A — No policy; individual engineers use whatever tools they prefer
- [ ] B — AI coding assistants are informally approved or tolerated; no governance policy
- [ ] C — AI coding assistant policy exists covering approved tools, data handling, and IP considerations
- [ ] D — AI coding assistants are a platform-provided capability; usage metrics are tracked; prompt guidance is available
- [ ] E — AI coding assistant usage, quality, and impact on delivery metrics are measured; feedback loops improve guidance continuously

*Level threshold: A=0, B=1, C=2, D=3-4, E=5*

---

**D8-Q2. How is AI used in infrastructure and platform operations?**

- [ ] A — AI is not used in platform operations
- [ ] B — AI tools are used ad hoc by platform engineers for IaC generation, documentation, or troubleshooting
- [ ] C — AI-assisted IaC review is integrated into workflows; misconfigurations are detected before apply
- [ ] D — LLM-assisted incident response is operational: runbooks are surfaced automatically, context is aggregated, remediation is suggested
- [ ] E — AI agents handle routine operational tasks (cost optimisation, alert triage, capacity scaling) within defined authority boundaries; all actions are audited

*Level threshold: A=0, B=1, C=2, D=3-4, E=5-6*

---

**D8-Q3. How are AI-generated artefacts (code, IaC, configs) governed?**

- [ ] A — No governance; AI-generated artefacts are treated the same as human-generated ones
- [ ] B — AI-generated code is reviewed manually; no automated quality gates specific to AI output
- [ ] C — AI-generated artefacts are flagged in review processes; additional scrutiny is applied
- [ ] D — Automated governance gates exist for AI-generated IaC: policy checks, security scanning, and diff review are automated before any AI-suggested change is applied
- [ ] E — AI generation and governance is a platform feature: teams use AI within governed guardrails; the platform tracks AI error rates and improves guidance accordingly

*Level threshold: A=0, B=1, C=2, D=3-4, E=5*

---

**D8-Q4. How are AI agents or autonomous systems integrated with your platform?**

- [ ] A — No AI agents integrated with the platform
- [ ] B — Some automation scripts or bots exist but are not AI-driven (rule-based)
- [ ] C — AI-powered automation handles specific, well-defined tasks (e.g., automated PR review, cost anomaly alerting)
- [ ] D — AI agents have defined API access to platform resources (deployment, scaling, alerting) with structured authority boundaries and audit logging
- [ ] E — MCP (Model Context Protocol) or equivalent provides structured platform API access for AI agents; multiple agents operate within the platform with clearly defined authority scopes, audit trails, and human oversight mechanisms

*Level threshold: A=0, B=1, C=2, D=3-4, E=5-6*

---

**D8-Q5. How is the impact of AI tooling on developer productivity measured?**

- [ ] A — Not measured
- [ ] B — Anecdotal evidence only; no systematic measurement
- [ ] C — AI tool adoption is tracked; developers report improved productivity in surveys
- [ ] D — AI impact is measured through delivery metrics: code review time, deployment frequency, incident response time before/after AI tool adoption
- [ ] E — AI impact is quantified across multiple dimensions; ROI of AI tooling investment is reported to leadership; measurement drives AI tooling roadmap decisions

*Level threshold: A=0, B=1, C=2, D=3-4, E=5*

---

## Evidence and Validation Questions

After completing the domain questions, answer the following validation questions. These do not contribute to scoring but help assess the reliability of your self-assessment.

**V1. For any capability you scored at Level 4 or above, can you provide a concrete example of a developer who used it self-service without platform team involvement in the last 30 days?**

*If you cannot provide a specific example, consider downgrading that capability by one level.*

---

**V2. What is your last measured developer NPS score and when was it measured?**

*If more than 6 months ago, Domain 3 and Domain 7 scores above Level 2 should be reviewed critically.*

---

**V3. What percentage of your services have SLOs defined with error budget tracking?**

*If less than 50%, Domain 4 scores above Level 2 should be reviewed.*

---

**V4. Can you name the three highest-priority items on your platform roadmap for the next quarter, and explain why each was selected?**

*If you cannot answer this, Domain 7 scores above Level 2 should be reviewed.*

---

**V5. In the last 90 days, what platform capability did your team release in response to developer feedback, and what evidence did you have that it was needed?**

*If you cannot answer this, Domain 3 and Domain 7 scores above Level 3 should be reviewed.*

---

## Scoring Summary

Transfer your answers to `maturity-scorecard.xlsx`. Each answer maps to a level score (0–6). The scorecard calculates:

1. A domain score for each of the eight domains (average of question scores within the domain)
2. A weighted composite maturity score
3. A radar chart showing your capability profile
4. Ceiling constraint analysis identifying the domains most limiting your overall maturity
5. A gap analysis showing the delta between your current state and your target state

**Allow 15–20 minutes to transfer answers and review scorecard outputs.**
