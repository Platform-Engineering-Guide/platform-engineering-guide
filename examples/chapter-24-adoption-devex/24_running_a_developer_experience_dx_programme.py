# Automated DX survey distribution and analysis pipeline (simplified)
# Triggered quarterly; distributes survey, collects results, generates report

import datetime
from typing import Optional

SURVEY_QUESTIONS = [
    {
        "id": "overall_satisfaction",
        "text": "On a scale of 0-10, how satisfied are you with the platform overall?",
        "type": "nps"
    },
    {
        "id": "deployment_satisfaction",
        "text": "On a scale of 1-5, how satisfied are you with the deployment pipeline?",
        "type": "likert"
    },
    {
        "id": "observability_satisfaction",
        "text": "On a scale of 1-5, how satisfied are you with the observability tooling?",
        "type": "likert"
    },
    {
        "id": "toil_percentage",
        "text": "Approximately what percentage of your engineering time last week was spent on repetitive, manual, automatable work?",
        "type": "percentage"
    },
    {
        "id": "biggest_frustration",
        "text": "What is the single most frustrating thing about working with the platform?",
        "type": "freetext"
    },
    {
        "id": "most_wanted_capability",
        "text": "What platform capability would most improve your daily work if it existed?",
        "type": "freetext"
    }
]

def calculate_nps(scores: list[int]) -> float:
    """Calculate Net Promoter Score from a list of 0-10 ratings."""
    promoters = sum(1 for s in scores if s >= 9)
    detractors = sum(1 for s in scores if s <= 6)
    total = len(scores)
    return ((promoters - detractors) / total) * 100

def generate_survey_report(responses: list[dict], previous_quarter: Optional[dict] = None) -> dict:
    """Aggregate survey responses and compute trends vs. previous quarter."""
    nps_scores = [r["overall_satisfaction"] for r in responses if "overall_satisfaction" in r]
    current_nps = calculate_nps(nps_scores)

    report = {
        "quarter": datetime.date.today().strftime("Q%q %Y"),
        "response_count": len(responses),
        "nps": current_nps,
        "nps_trend": current_nps - previous_quarter["nps"] if previous_quarter else None,
        "avg_toil_percentage": sum(r["toil_percentage"] for r in responses) / len(responses),
        "capability_scores": {
            "deployment": sum(r["deployment_satisfaction"] for r in responses) / len(responses),
            "observability": sum(r["observability_satisfaction"] for r in responses) / len(responses),
        },
        "top_frustrations": extract_themes([r["biggest_frustration"] for r in responses]),
        "top_wanted_capabilities": extract_themes([r["most_wanted_capability"] for r in responses])
    }
    return report
