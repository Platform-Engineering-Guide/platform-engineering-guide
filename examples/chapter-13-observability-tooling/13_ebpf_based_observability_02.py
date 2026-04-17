# PxL script: HTTP error analysis for the payments service
import px

# Get all HTTP requests to the payments service in the last 5 minutes
df = px.DataFrame(table='http_events', start_time='-5m')
df = df[df.ctx['namespace'] == 'payments']
df = df[df.resp_status >= 400]

# Group by status code and URL path
df = df.groupby(['req_path', 'resp_status']).agg(
    count=('latency_ns', px.count),
    p50=('latency_ns', px.percentile(50)),
    p99=('latency_ns', px.percentile(99)),
)

df['p50_ms'] = df['p50'] / 1e6
df['p99_ms'] = df['p99'] / 1e6

px.display(df[['req_path', 'resp_status', 'count', 'p50_ms', 'p99_ms']])
