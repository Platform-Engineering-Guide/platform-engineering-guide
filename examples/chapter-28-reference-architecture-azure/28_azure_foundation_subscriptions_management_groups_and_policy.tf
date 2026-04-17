# Crossplane or Terraform: Azure Policy Initiative for platform baseline
resource "azurerm_policy_set_definition" "platform_baseline" {
  name         = "platform-security-baseline"
  policy_type  = "Custom"
  display_name = "Platform Engineering Security Baseline"

  policy_definition_reference {
    policy_definition_id = data.azurerm_policy_definition.require_tags.id
    parameter_values = jsonencode({
      tagName = { value = "cost-centre" }
    })
  }

  policy_definition_reference {
    policy_definition_id = data.azurerm_policy_definition.deny_public_ip.id
  }

  policy_definition_reference {
    policy_definition_id = data.azurerm_policy_definition.require_private_endpoints.id
  }

  policy_definition_reference {
    policy_definition_id = data.azurerm_policy_definition.audit_aks_policy_addon.id
  }
}

resource "azurerm_management_group_policy_assignment" "platform_baseline" {
  name                 = "platform-baseline"
  management_group_id  = azurerm_management_group.workloads.id
  policy_definition_id = azurerm_policy_set_definition.platform_baseline.id
  location             = "uksouth"

  identity {
    type = "SystemAssigned"
  }
}
