resource "azurerm_container_registry" "platform" {
  name                = "acmecorpplatform"
  resource_group_name = azurerm_resource_group.platform.name
  location            = var.location
  sku                 = "Premium"  # Required for geo-replication and private endpoints
  admin_enabled       = false      # Never enable admin credentials

  network_rule_set {
    default_action = "Deny"
  }

  private_endpoint_enabled = true
}

# Grant AKS clusters pull access via managed identity — no pull secrets needed
resource "azurerm_role_assignment" "aks_acr_pull" {
  principal_id                     = azurerm_kubernetes_cluster.platform.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.platform.id
  skip_service_principal_aad_check = true
}
