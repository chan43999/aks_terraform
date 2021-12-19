resource "azurerm_network_security_group" "nsg" {
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  name                = "${var.aks_name}-nsg"
  tags                = merge(var.default_tags, var.nsg_extra_tags)
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.aks_name}-vnet"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = var.ip_addresses.vnet_address_space
  tags                = merge(var.default_tags, var.vnet_extra_tags)

  subnet {
    address_prefix = var.ip_addresses.subnet_address_prefix
    name           = "${var.aks_name}-vnet-subnet"
    security_group = azurerm_network_security_group.nsg.id
  }
}

resource "azurerm_role_assignment" "vnet_role_assignment" {
  principal_id         = azurerm_kubernetes_cluster.aks.identity[0].principal_id
  scope                = azurerm_virtual_network.vnet.id
  role_definition_name = "Contributor"
}