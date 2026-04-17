resource "azurerm_kubernetes_cluster_node_pool" "platform_services" {
  name                  = "platform"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.platform.id
  vm_size               = "Standard_D8s_v5"
  node_count            = 3
  os_disk_type          = "Ephemeral"
  vnet_subnet_id        = azurerm_subnet.aks_user.id
  max_pods              = 110

  node_labels = {
    "workload-type" = "platform-services"
  }

  node_taints = ["workload-type=platform-services:NoSchedule"]

  upgrade_settings {
    max_surge = "33%"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "workloads" {
  name                  = "workloads"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.platform.id
  vm_size               = "Standard_D4s_v5"
  enable_auto_scaling   = true
  min_count             = 2
  max_count             = 20
  os_disk_type          = "Ephemeral"
  vnet_subnet_id        = azurerm_subnet.aks_user.id
}
