# vault-agent-config.hcl — Vault Agent configuration
vault {
  address = "https://vault.internal.acme.io:8200"
}

auto_auth {
  method "kubernetes" {
    mount_path = "auth/kubernetes"
    config = {
      role = "payments-service"
      token_path = "/var/run/secrets/kubernetes.io/serviceaccount/token"
    }
  }

  sink "file" {
    config = {
      path = "/vault/token"
    }
  }
}

template {
  source      = "/vault/templates/db-config.tpl"
  destination = "/vault/secrets/db-config.properties"
  perms       = "0640"

  # Restart the application when secrets are rotated
  exec {
    command = ["sh", "-c", "kill -HUP $(cat /app/app.pid) 2>/dev/null || true"]
    timeout = "30s"
  }
}

template {
  contents    = <<EOF
{{ with secret "database/creds/payments-service" }}
spring.datasource.url=jdbc:postgresql://{{ .Data.host }}:5432/payments
spring.datasource.username={{ .Data.username }}
spring.datasource.password={{ .Data.password }}
{{ end }}
EOF
  destination = "/vault/secrets/application-db.properties"
}
