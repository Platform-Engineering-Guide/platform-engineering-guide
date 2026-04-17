# Platform MCP server — exposes curated platform capabilities to AI agents
# Using the official MCP Python SDK

from mcp.server import Server
from mcp.server.models import InitializationOptions
from mcp.types import Tool, TextContent, Resource
import mcp.server.stdio
import asyncio
import httpx

app = Server("platform-mcp-server")

@app.list_tools()
async def list_tools() -> list[Tool]:
    """Expose platform capabilities as MCP tools."""
    return [
        Tool(
            name="get_service_info",
            description="Retrieve information about a platform service from the service catalogue, including owner, dependencies, SLOs, and recent deployments.",
            inputSchema={
                "type": "object",
                "properties": {
                    "service_name": {
                        "type": "string",
                        "description": "The name of the service as registered in the service catalogue"
                    }
                },
                "required": ["service_name"]
            }
        ),
        Tool(
            name="get_deployment_status",
            description="Get the current deployment status for a service in a given environment.",
            inputSchema={
                "type": "object",
                "properties": {
                    "service_name": {"type": "string"},
                    "environment": {
                        "type": "string",
                        "enum": ["development", "staging", "production"]
                    }
                },
                "required": ["service_name", "environment"]
            }
        ),
        Tool(
            name="get_service_metrics",
            description="Retrieve current observability metrics for a service: error rate, latency percentiles, and request rate.",
            inputSchema={
                "type": "object",
                "properties": {
                    "service_name": {"type": "string"},
                    "window_minutes": {
                        "type": "integer",
                        "description": "Time window for metrics in minutes (default: 30)",
                        "default": 30
                    }
                },
                "required": ["service_name"]
            }
        ),
        # Supervised write tool — requires approval workflow
        Tool(
            name="create_deployment_request",
            description="Create a deployment request for human approval. Does NOT deploy immediately. Returns a request ID that must be approved via the platform portal before deployment proceeds.",
            inputSchema={
                "type": "object",
                "properties": {
                    "service_name": {"type": "string"},
                    "target_version": {"type": "string"},
                    "environment": {"type": "string", "enum": ["staging", "production"]},
                    "reason": {"type": "string", "description": "Explanation of why this deployment is being requested"}
                },
                "required": ["service_name", "target_version", "environment", "reason"]
            }
        )
    ]

@app.call_tool()
async def call_tool(name: str, arguments: dict) -> list[TextContent]:
    """Handle tool calls with appropriate authorization checks."""

    # Every tool call is audit-logged before execution
    await audit_log_tool_call(name, arguments)

    if name == "get_service_info":
        result = await fetch_from_backstage(arguments["service_name"])
        return [TextContent(type="text", text=result)]

    elif name == "get_deployment_status":
        result = await fetch_argocd_status(
            arguments["service_name"],
            arguments["environment"]
        )
        return [TextContent(type="text", text=result)]

    elif name == "get_service_metrics":
        result = await fetch_prometheus_metrics(
            arguments["service_name"],
            arguments.get("window_minutes", 30)
        )
        return [TextContent(type="text", text=result)]

    elif name == "create_deployment_request":
        # Write action: create a pending approval request, do not execute
        request_id = await create_approval_request(arguments)
        return [TextContent(
            type="text",
            text=f"Deployment request created with ID: {request_id}. "
                 f"A platform engineer must approve this request at "
                 f"https://platform.internal/approvals/{request_id} before deployment proceeds."
        )]

    raise ValueError(f"Unknown tool: {name}")

async def main():
    async with mcp.server.stdio.stdio_server() as (read_stream, write_stream):
        await app.run(
            read_stream,
            write_stream,
            InitializationOptions(
                server_name="platform-mcp-server",
                server_version="0.1.0",
            )
        )

if __name__ == "__main__":
    asyncio.run(main())
