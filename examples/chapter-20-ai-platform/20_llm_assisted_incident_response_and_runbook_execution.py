# Simplified incident context builder for LLM-assisted triage
# Runs when a P1/P2 incident is declared; feeds context to LLM

import anthropic
from datetime import datetime, timedelta

def build_incident_context(incident_id: str, affected_service: str) -> str:
    """
    Gather relevant context from observability and incident management systems.
    Returns a structured context string for the LLM prompt.
    """
    recent_deployments = get_recent_deployments(affected_service, hours=4)
    active_alerts = get_correlated_alerts(affected_service, minutes=30)
    dependencies = get_service_dependencies(affected_service)
    config_changes = get_recent_config_changes(affected_service, hours=24)

    context = f"""
INCIDENT: {incident_id}
AFFECTED SERVICE: {affected_service}
DECLARED AT: {datetime.utcnow().isoformat()}

RECENT DEPLOYMENTS (last 4 hours):
{format_deployments(recent_deployments)}

ACTIVE ALERTS (correlated):
{format_alerts(active_alerts)}

SERVICE DEPENDENCIES:
{format_dependencies(dependencies)}

RECENT CONFIGURATION CHANGES (last 24 hours):
{format_changes(config_changes)}
"""
    return context

def get_incident_triage(incident_id: str, affected_service: str) -> str:
    client = anthropic.Anthropic()
    context = build_incident_context(incident_id, affected_service)

    response = client.messages.create(
        model="claude-opus-4-6",
        max_tokens=1500,
        system="""You are an SRE incident response assistant. Given incident context,
        provide: 1) A one-paragraph summary of what is likely happening,
        2) The three most likely root causes in priority order with reasoning,
        3) Immediate mitigation steps to reduce customer impact,
        4) Diagnostic commands to run to confirm the root cause.
        Be concise and actionable. Flag if you are uncertain.""",
        messages=[{"role": "user", "content": context}]
    )

    return response.content[0].text
