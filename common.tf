data "azurerm_subscription" "current" {
}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

locals {
  aks_config = length(azurerm_kubernetes_cluster.aks.kube_admin_config) >= 1 ? azurerm_kubernetes_cluster.aks.kube_admin_config[0] : azurerm_kubernetes_cluster.aks.kube_config[0]
}