#!/usr/bin/env python3
"""
Monthly cost allocation export for chargeback.
Queries OpenCost API, aggregates by team label, applies shared cost
allocation, and writes output to S3 in Parquet format.

Run as a scheduled job at the end of each calendar month.
"""

import os
import json
import boto3
import requests
import pandas as pd
from datetime import datetime, timedelta
from io import BytesIO

OPENCOST_API = os.environ["OPENCOST_API_URL"]
S3_BUCKET = os.environ["CHARGEBACK_S3_BUCKET"]
SHARED_COST_NAMESPACES = ["kube-system", "platform-system", "monitoring", "ingress-nginx"]

def get_namespace_costs(start: str, end: str) -> dict:
    """Fetch namespace-level costs from OpenCost API."""
    response = requests.get(
        f"{OPENCOST_API}/allocation",
        params={
            "window": f"{start},{end}",
            "aggregate": "namespace",
            "includeIdle": "true",
            "idleByNode": "false",
        },
        timeout=30,
    )
    response.raise_for_status()
    return response.json()["data"][0]  # First window result

def allocate_shared_costs(namespace_costs: dict) -> tuple[dict, float]:
    """
    Separate shared (platform) namespace costs from tenant costs.
    Returns tenant costs and total shared cost to be distributed.
    """
    shared_total = 0.0
    tenant_costs = {}

    for ns, data in namespace_costs.items():
        total = data.get("totalCost", 0.0)
        if any(ns.startswith(shared_ns) for shared_ns in SHARED_COST_NAMESPACES):
            shared_total += total
        elif ns != "__idle__":
            tenant_costs[ns] = data

    return tenant_costs, shared_total

def build_chargeback_report(
    tenant_costs: dict,
    shared_total: float,
    period_start: str,
    period_end: str,
) -> pd.DataFrame:
    """Build chargeback report with shared cost amortisation."""
    rows = []
    total_tenant_cost = sum(
        d.get("totalCost", 0.0) for d in tenant_costs.values()
    )

    for ns, data in tenant_costs.items():
        labels = data.get("properties", {}).get("labels", {})
        ns_cost = data.get("totalCost", 0.0)
        # Amortise shared costs proportionally by namespace compute cost
        shared_allocation = (
            (ns_cost / total_tenant_cost * shared_total)
            if total_tenant_cost > 0
            else 0.0
        )
        rows.append({
            "period_start": period_start,
            "period_end": period_end,
            "namespace": ns,
            "team": labels.get("team", "unattributed"),
            "cost_centre": labels.get("cost-centre", "unattributed"),
            "product": labels.get("product", "unattributed"),
            "environment": labels.get("environment", "unknown"),
            "compute_cost_usd": round(ns_cost, 4),
            "shared_cost_allocation_usd": round(shared_allocation, 4),
            "total_cost_usd": round(ns_cost + shared_allocation, 4),
            "currency": "USD",
        })

    return pd.DataFrame(rows)

def write_to_s3(df: pd.DataFrame, period_start: str) -> str:
    """Write chargeback report to S3 in Parquet format."""
    year_month = period_start[:7]  # e.g., "2026-01"
    key = f"chargeback/{year_month}/platform-chargeback.parquet"

    buffer = BytesIO()
    df.to_parquet(buffer, index=False, engine="pyarrow")
    buffer.seek(0)

    s3 = boto3.client("s3")
    s3.put_object(
        Bucket=S3_BUCKET,
        Key=key,
        Body=buffer.getvalue(),
        ContentType="application/octet-stream",
    )
    return f"s3://{S3_BUCKET}/{key}"

def main():
    # Calculate previous month date range
    today = datetime.utcnow()
    first_of_month = today.replace(day=1)
    last_month_end = first_of_month - timedelta(days=1)
    last_month_start = last_month_end.replace(day=1)

    period_start = last_month_start.strftime("%Y-%m-%dT00:00:00Z")
    period_end = last_month_end.strftime("%Y-%m-%dT23:59:59Z")

    print(f"Generating chargeback report for {period_start} to {period_end}")

    namespace_costs = get_namespace_costs(period_start, period_end)
    tenant_costs, shared_total = allocate_shared_costs(namespace_costs)

    print(f"Found {len(tenant_costs)} tenant namespaces, shared cost: ${shared_total:.2f}")

    report = build_chargeback_report(tenant_costs, shared_total, period_start, period_end)
    output_path = write_to_s3(report, period_start)

    print(f"Chargeback report written to {output_path}")
    print(f"Total attributed cost: ${report['total_cost_usd'].sum():.2f}")
    unattributed = report[report["team"] == "unattributed"]["total_cost_usd"].sum()
    if unattributed > 0:
        print(f"WARNING: ${unattributed:.2f} is unattributed (missing team label)")

if __name__ == "__main__":
    main()
