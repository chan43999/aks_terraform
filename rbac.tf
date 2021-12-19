resource "azurerm_role_assignment" "aks_aad_role_assignments" {
  for_each = { for item in distinct(
  [for subject in flatten(
  [for binding in concat(values(var.aks_rolebindings), values(var.aks_cluster_rolebindings)) : [for subjects in binding : binding["subjects"]]])
  : subject["id"]]) : item => item
  }

  principal_id         = each.key
  role_definition_name = "Azure Kubernetes Service Cluster User Role"
  scope                = azurerm_kubernetes_cluster.aks.id
}

resource "azurerm_role_assignment" "aks_identity_rg_operator" {
  principal_id         = try(azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id, "")
  scope                = data.azurerm_resource_group.rg.id
  role_definition_name = "Managed Identity Operator"
}

locals {
  node_resource_group_id = "${data.azurerm_subscription.current.id}/resourceGroups/${azurerm_kubernetes_cluster.aks.node_resource_group}"
}

resource "azurerm_role_assignment" "aks_identity_aks_rg_operator" {
  principal_id         = try(azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id, "")
  scope                = local.node_resource_group_id
  role_definition_name = "Managed Identity Operator"
}

resource "azurerm_role_assignment" "aks_identity_aks_rg_vm" {
  principal_id         = try(azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id, "")
  scope                = local.node_resource_group_id
  role_definition_name = "Virtual Machine Contributor"
}