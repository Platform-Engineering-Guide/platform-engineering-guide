# 1. Create a Managed Identity (preferred over App Registration for platform components)
az identity create \
  --name external-secrets-identity \
  --resource-group platform-shared-services

# 2. Create the federated credential linking the Managed Identity to the K8s service account
az identity federated-credential create \
  --name external-secrets-fedcred \
  --identity-name external-secrets-identity \
  --resource-group platform-shared-services \
  --issuer "$(az aks show -g platform-production -n platform-production \
              --query oidcIssuerProfile.issuerUrl -o tsv)" \
  --subject "system:serviceaccount:external-secrets:external-secrets-sa" \
  --audience api://AzureADTokenExchange

# 3. Annotate the Kubernetes service account
kubectl annotate serviceaccount external-secrets-sa \
  --namespace external-secrets \
  azure.workload.identity/client-id="<managed-identity-client-id>"
