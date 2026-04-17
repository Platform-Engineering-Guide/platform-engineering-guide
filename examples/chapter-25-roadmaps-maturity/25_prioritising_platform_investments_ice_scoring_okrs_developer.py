# ICE scoring for platform backlog items
from dataclasses import dataclass
from typing import Optional

@dataclass
class BacklogItem:
    id: str
    title: str
    description: str
    impact: int          # 1-10: how many developers affected * severity
    confidence: int      # 1-10: how certain are we this will work
    ease: int            # 1-10: how straightforward to implement
    requester: str
    survey_evidence: Optional[str] = None
    dora_impact: Optional[str] = None

    @property
    def ice_score(self) -> float:
        return (self.impact * self.confidence * self.ease) / 100

    def __repr__(self) -> str:
        return f"{self.title}: ICE={self.ice_score:.1f} (I={self.impact}, C={self.confidence}, E={self.ease})"

# Example backlog scoring
backlog = [
    BacklogItem(
        id="PLAT-142",
        title="Self-service database provisioning",
        description="Allow developers to provision RDS instances via service catalogue without platform team ticket",
        impact=8,       # Affects all teams that use databases; high-frequency request
        confidence=9,   # We have done similar work before; requirements are clear
        ease=4,         # Moderate complexity: Crossplane composition + approval workflow
        requester="Multiple teams",
        survey_evidence="Top-3 pain point in Q3 developer survey; 67% of respondents cited DB provisioning as a bottleneck",
        dora_impact="Reduces average environment setup time by estimated 3 days"
    ),
    BacklogItem(
        id="PLAT-156",
        title="Automated cost anomaly alerting",
        description="Alert team leads when their cloud costs increase unexpectedly week-over-week",
        impact=6,       # Affects engineering managers and finance; medium frequency
        confidence=7,   # Technically straightforward but alert fatigue risk
        ease=7,         # OpenCost API + Slack webhook; well-understood implementation
        requester="Engineering leadership",
    ),
    BacklogItem(
        id="PLAT-134",
        title="Multi-region deployment support",
        description="Enable services to be deployed across multiple AWS regions with automatic traffic routing",
        impact=4,       # Affects only services with global traffic requirements
        confidence=5,   # Complex requirements; multiple architectural approaches
        ease=2,         # High complexity: multi-region state, DNS, failover
        requester="Payments team",
    ),
]

# Sort by ICE score descending
prioritised = sorted(backlog, key=lambda x: x.ice_score, reverse=True)
for item in prioritised:
    print(item)
