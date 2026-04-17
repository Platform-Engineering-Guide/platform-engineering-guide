// Grafonnet dashboard definition
local grafana = import 'grafonnet/grafana.libsonnet';
local dashboard = grafana.dashboard;
local row = grafana.row;
local prometheus = grafana.prometheus;
local graphPanel = grafana.graphPanel;

dashboard.new(
  'Service Overview',
  schemaVersion=36,
  tags=['service', 'platform'],
  refresh='30s',
)
.addTemplate(
  grafana.template.datasource(
    'PROMETHEUS_DS',
    'prometheus',
    'Prometheus',
  )
)
.addPanel(
  graphPanel.new(
    'Request Rate',
    datasource='$PROMETHEUS_DS',
    format='reqps',
  )
  .addTarget(
    prometheus.target(
      'sum(rate(http_requests_total{service_name="$service_name"}[2m]))',
      legendFormat='req/s',
    )
  ),
  gridPos={ x: 0, y: 0, w: 12, h: 8 }
)
