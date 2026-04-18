# Platform Engineering Maturity — Improvement Roadmap Template

**Version:** 1.0 — 2026 Edition  
**Instructions:** Complete the shaded sections. Use your Gap Analysis output from `maturity-scorecard.xlsx` to populate the priority domains and target levels. Review quarterly.

---

## Organisation Context

| Field | Value |
|-------|-------|
| Organisation name | |
| Assessment date | |
| Current composite maturity score | |
| Current overall maturity level | |
| Target composite maturity score (12 months) | |
| Target overall maturity level (12 months) | |
| Platform team size (FTE) | |
| Number of development teams served | |
| Number of services in production | |
| Platform PM assigned? (Y/N) | |
| Assessment conducted by | |

---

## Priority Domain Summary

*Pull from the Gap Analysis sheet. List domains in priority order (largest gap × highest weight first).*

| Priority | Domain | Current Level | Target (12m) | Gap | Constraint Type |
|----------|--------|---------------|--------------|-----|-----------------|
| 1 | | | | | |
| 2 | | | | | |
| 3 | | | | | |
| 4 | | | | | |
| 5 | | | | | |
| 6 | | | | | |
| 7 | | | | | |
| 8 | | | | | |

**Constraint type legend:**

- **Ceiling** — This domain is below Level 2 and limits all other domains
- **Adoption** — Capability exists but is not widely used; DX or enablement problem
- **Technical** — Specific technical capability is missing; engineering investment needed
- **Organisational** — Requires structural or process change; not solvable with engineering alone

---

## 90-Day Sprint Plan

**Principle:** The 90-day sprint should focus on one to two domains maximum. Attempting to advance multiple domains simultaneously typically advances none of them. Choose the domain with the highest ceiling constraint or the largest weighted gap.

### Sprint Goal

*One sentence describing what is different about your platform in 90 days.*

> [Enter sprint goal here]

### Focus Domain(s)

**Primary domain:** [Domain ID and name]  
**Current level:** [X.X]  
**Target level by end of sprint:** [X.X]  
**Secondary domain (optional):** [Domain ID and name]  

---

### Sprint Workstreams

#### Workstream 1: [Name]

**Domain:** [Domain ID]  
**Objective:** [One sentence — what capability will exist that does not today]  
**Success metric:** [Measurable outcome — not "implement X" but "developers can do Y without platform team involvement"]

| Week | Milestone | Owner | Dependencies |
|------|-----------|-------|--------------|
| 1–2 | | | |
| 3–4 | | | |
| 5–6 | | | |
| 7–8 | | | |
| 9–10 | | | |
| 11–12 | | | |

**Risks:**

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| | | | |

**Definition of Done:**

- [ ] [Specific, testable completion criterion]
- [ ] [Specific, testable completion criterion]
- [ ] Developer NPS impact measured (before/after or A/B where possible)

---

#### Workstream 2: [Name] *(optional)*

**Domain:** [Domain ID]  
**Objective:** [One sentence]  
**Success metric:** [Measurable outcome]

| Week | Milestone | Owner | Dependencies |
|------|-----------|-------|--------------|
| 1–2 | | | |
| 3–6 | | | |
| 7–12 | | | |

**Definition of Done:**

- [ ] [Specific, testable completion criterion]
- [ ] [Specific, testable completion criterion]

---

### Sprint Risks and Assumptions

| Assumption | Risk if Wrong | Contingency |
|------------|---------------|-------------|
| Team capacity will not be consumed by operational incidents | Sprint deliverables slip | Pre-identify sprint items that can be de-scoped without losing value |
| [Add assumption] | | |

---

## 6-Month Plan

**Principle:** The 6-month plan should advance two to three domains. Be explicit about sequencing — some capabilities are prerequisites for others.

### 6-Month Goals

By month 6, the platform will:

1. [Goal — domain-specific, measurable]
2. [Goal — domain-specific, measurable]
3. [Goal — domain-specific, measurable]

### Domain Progression Targets

| Domain | Current | Month 3 | Month 6 | Key Deliverable |
|--------|---------|---------|---------|-----------------|
| D1 — Infrastructure & Provisioning | | | | |
| D2 — Delivery & Deployment | | | | |
| D3 — Developer Experience | | | | |
| D4 — Observability | | | | |
| D5 — Security & Compliance | | | | |
| D6 — FinOps & Cost Management | | | | |
| D7 — Organisational Model | | | | |
| D8 — AI & Automation | | | | |

### Sequencing Logic

*Explain why domains are being addressed in this order. Call out prerequisites explicitly.*

> [Enter sequencing rationale here. Example: "We are addressing D1 before D3 because self-service environment provisioning is a prerequisite for the developer portal workflow templates. Without D1 capability, the portal cannot offer meaningful self-service beyond documentation."]

### Headcount and Investment Requirements

| Requirement | Current State | Required | Timeline | Justification |
|-------------|---------------|----------|----------|---------------|
| Platform engineers | | | | |
| Platform PM | | | | |
| DX specialist / technical writer | | | | |
| Tooling budget (£/$/€ per month) | | | | |
| Training | | | | |

### Key Dependencies on Other Teams

| Dependency | Owner | Required By | Risk if Not Available |
|------------|-------|-------------|----------------------|
| [e.g. Security team sign-off on policy framework] | | | |
| [e.g. Finance approval for FinOps tooling budget] | | | |

---

## 12-Month Plan

**Principle:** The 12-month plan sets directional intent, not detailed plans. Detail should emerge from quarterly planning cycles. Use this section to communicate strategic direction and secure investment.

### 12-Month Vision Statement

*Two to three sentences describing the platform's position relative to today. What can developers do that they cannot do today? How has the platform team's operating model changed?*

> [Enter vision statement here]

### Target Maturity Profile (12 months)

| Domain | Current Level | 12-Month Target | Change |
|--------|---------------|-----------------|--------|
| D1 — Infrastructure & Provisioning | | | +[x] |
| D2 — Delivery & Deployment | | | +[x] |
| D3 — Developer Experience | | | +[x] |
| D4 — Observability | | | +[x] |
| D5 — Security & Compliance | | | +[x] |
| D6 — FinOps & Cost Management | | | +[x] |
| D7 — Organisational Model | | | +[x] |
| D8 — AI & Automation | | | +[x] |
| **Composite Score** | **[current]** | **[target]** | **+[x]** |

### Strategic Initiatives (12-Month Horizon)

*Name the 3–5 strategic initiatives that will move the platform from its current state to the 12-month target. These are larger than sprint workstreams — each should span multiple quarters.*

#### Initiative 1: [Name]

**Domains addressed:** [List]  
**Expected maturity delta:** [e.g. D3: 2 → 4, D7: 2 → 3]  
**Investment required:** [Headcount, budget]  
**Expected outcomes:**

- Developer NPS improvement: [target]
- Deployment frequency improvement: [target]
- Onboarding time improvement: [target]
- Other: [metric]

---

#### Initiative 2: [Name]

**Domains addressed:** [List]  
**Expected maturity delta:** [e.g. D5: 2 → 4]  
**Investment required:** [Headcount, budget]  
**Expected outcomes:**

- [Metric and target]
- [Metric and target]

---

#### Initiative 3: [Name]

**Domains addressed:** [List]  
**Expected maturity delta:** [e.g. D6: 1 → 3]  
**Investment required:** [Headcount, budget]  
**Expected outcomes:**

- Cloud cost reduction: [target % or £/$]
- [Other metric and target]

---

### Business Case Summary

*Use this section when presenting the roadmap to engineering leadership or the C-suite. Translate platform improvements into business outcomes.*

| Platform Improvement | Current State | 12-Month Target | Business Outcome | Estimated Value |
|---------------------|---------------|-----------------|------------------|-----------------|
| Deployment frequency | [x/month] | [x/week] | Faster feature delivery to customers | |
| Onboarding time | [x days] | [x hours] | Reduced time-to-productivity for new engineers | |
| MTTR | [x hours] | [x minutes] | Reduced customer impact from incidents | |
| Cloud cost efficiency | [baseline] | [target] | Cloud cost reduction | [£/$] |
| Developer NPS | [score] | [target] | Improved retention, reduced attrition | |
| Compliance overhead | [audit prep days] | [audit prep days] | Engineering time redirected to product work | |

**Total estimated annual value of platform improvements:** [£/$]  
**Total platform investment (12 months):** [£/$]  
**ROI:** [x:1]

---

## Quarterly Review Checklist

Use this checklist at each quarterly review to assess progress and calibrate the roadmap.

### Assessment

- [ ] Reassess maturity scorecard (all 40 questions)
- [ ] Compare composite score to previous quarter
- [ ] Identify domains that did not progress as planned — understand why
- [ ] Identify domains that progressed faster than planned — document what worked

### Developer Experience

- [ ] Developer NPS survey completed (if due this quarter)
- [ ] Portal usage analytics reviewed
- [ ] Developer pain survey conducted or reviewed
- [ ] Onboarding time measured and compared to target

### Platform Operations

- [ ] DORA metrics reviewed (deployment frequency, lead time, MTTR, change failure rate)
- [ ] Platform SLA compliance reviewed
- [ ] Platform incident retrospectives completed
- [ ] Cloud cost efficiency reviewed

### Roadmap Calibration

- [ ] Current quarter's sprint goals assessed against definition of done
- [ ] Next quarter's sprint plan drafted
- [ ] 6-month plan updated based on actual progress
- [ ] 12-month plan reviewed for continuing relevance
- [ ] Stakeholder communication prepared

### Organisational

- [ ] Platform team health check (team sentiment, burnout risk, skill gaps)
- [ ] Headcount and budget review against plan
- [ ] Dependencies on other teams reviewed
- [ ] Executive sponsor briefing completed

---

## Common Sequencing Patterns

These patterns reflect frequently observed progression paths. They are not universal — use them as reference, not prescription.

### Pattern A: Starting from Scratch (Level 0 → 2)

**Typical timeline:** 9–12 months  
**Sequence:**

1. Establish a platform team with clear mandate *(D7 first)*
2. Standardise IaC and cloud accounts *(D1)*
3. Consolidate onto a single CI/CD platform with shared templates *(D2)*
4. Centralise secrets management *(D5 baseline)*
5. Establish team-level cost visibility *(D6 baseline)*
6. Basic centralised observability *(D4 baseline)*
7. Begin developer portal with service catalogue *(D3)*

**Why this order:** Without D7 (a team with mandate), nothing else is possible. D1 and D2 establish the foundations everything else builds on. D3 (the portal) is expensive to build and maintain — it delivers most value once D1 and D2 are stable enough to expose through it.

---

### Pattern B: Breaking the Level 2 → 3 Stall

**Symptoms:** You have pipelines and IaC but developers still file tickets for every new environment. The platform team is a bottleneck. No developer portal exists or adoption is below 20%.

**Sequence:**

1. Implement developer portal (Backstage or commercial) with service catalogue *(D3)*
2. Build self-service environment provisioning (Crossplane or Terraform-based) *(D1)*
3. Create software templates for the top three service types *(D3)*
4. Implement SLO framework for top ten services *(D4)*
5. Assign or hire platform PM *(D7)*

**Why this order:** The portal makes existing capability discoverable. Self-service provisioning removes the highest-volume ticket type. Templates remove the second highest. SLOs begin the journey to treating the platform as a product. The PM hire is what makes D7 progress possible.

---

### Pattern C: Level 3 → 5 (Platform as Product)

**Symptoms:** You have an IDP but developer NPS is mediocre. Adoption is patchy — some teams use the platform deeply, others avoid it. The platform team is still involved in too many delivery workflows.

**Sequence:**

1. Hire or designate platform PM with real authority *(D7)*
2. Run developer experience research (interviews, journey mapping) *(D3)*
3. Instrument portal usage and identify adoption gaps *(D3)*
4. Close the top three adoption barriers identified by research *(D3)*
5. Implement chargeback with real-time cost visibility in portal *(D6)*
6. Achieve SLSA Level 2–3 and policy-as-code maturity *(D5)*
7. Establish platform SLAs and publish them *(D7)*
8. Implement developer NPS programme with quarterly cadence *(D3, D7)*

**Why this order:** Without a PM and structured feedback, improvements are guesswork. Research identifies the actual adoption barriers rather than assumed ones. Chargeback creates financial accountability that drives platform adoption. Security maturity is required before claiming Level 4–5 in D5.

---

### Pattern D: Regulatory or Compliance-Constrained Organisations

**Symptoms:** Security and compliance requirements constrain the pace of platform adoption. Audit preparation consumes significant engineering time. JIT access is a requirement but not yet implemented.

**Additional sequencing considerations:**

1. Prioritise D5 above D3 and D6 — without security baseline, self-service creates unacceptable risk
2. Implement policy-as-code before expanding self-service provisioning — guardrails before golden paths
3. Automate compliance evidence collection early — audit prep overhead compounds at scale
4. Engage compliance/security team as co-designers of platform capabilities, not reviewers after the fact

---

## Roadmap Anti-Patterns

**Anti-pattern: Boiling the ocean.** Attempting to advance all eight domains simultaneously. Result: nothing meaningful is delivered in any domain within a quarter. **Fix:** choose one to two domains per sprint; sequence aggressively.

**Anti-pattern: Portal-first without foundations.** Building a Backstage instance before D1 and D2 are stable. Result: the portal lists capabilities that are unreliable or unavailable. Developer trust in the portal is destroyed before it is built. **Fix:** establish D1 and D2 at Level 2+ before investing in D3.

**Anti-pattern: Technical-only roadmap.** Roadmap contains only engineering deliverables with no developer adoption targets. Result: excellent platform that nobody uses. **Fix:** every roadmap item must have a developer-facing outcome metric, not just an implementation milestone.

**Anti-pattern: Skipping organisational change.** Treating D7 (organisational model) as less important than technical domains. Result: the platform team remains a bottleneck despite technical investment because responsibilities and operating model have not changed. **Fix:** D7 improvements must be sequenced alongside technical improvements, not after them.

**Anti-pattern: Level 6 aspiration without Level 4 foundation.** Investing in AI-autonomous operations (D8) before achieving self-service basics. Result: AI systems operating on an unstable foundation amplify existing problems rather than solving them. **Fix:** D8 investment is appropriate once D1, D2, D3, and D4 are at Level 3+.
