resource "azurerm_kubernetes_cluster" "aks" {
  name = var.aks_name
  tags = merge(var.default_tags, var.aks_extra_tags)

  dns_prefix                      = var.aks_dns_prefix == null ? var.aks_name : var.aks_dns_prefix
  api_server_authorized_ip_ranges = var.api_server_authorized_ip_ranges
  enable_pod_security_policy      = var.enable_pod_security_policy
  kubernetes_version              = var.kubernetes_version
  node_resource_group             = var.node_resource_group

  private_cluster_enabled = false

  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.aks_location == null ? data.azurerm_resource_group.rg.location : var.aks_location

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    vm_size         = var.default_node_pool_core.vm_size
    os_disk_size_gb = var.default_node_pool_core.os_disk_size_gb
    node_count      = var.default_node_pool_core.node_count

    name                  = var.default_node_pool_name == null ? "nodes" : var.default_node_pool_name
    orchestrator_version  = var.kubernetes_version
    max_pods              = var.default_node_pool_max_pods
    enable_auto_scaling   = var.default_node_pool_scale.enable_auto_scaling
    max_count             = var.default_node_pool_scale.enable_auto_scaling ? var.default_node_pool_scale.max_count : null
    min_count             = var.default_node_pool_scale.enable_auto_scaling ? var.default_node_pool_scale.min_count : null
    type                  = var.default_node_pool_sla.type
    availability_zones    = var.default_node_pool_sla.availability_zones

    node_taints           = []
    enable_node_public_ip = false

  }

  network_profile {
    network_plugin     = var.network_plugin
    network_policy     = var.network_plugin == "azure" ? var.network_policy : null
    dns_service_ip     = var.ip_addresses.dns_service_ip
    docker_bridge_cidr = var.ip_addresses.docker_bridge_cidr
    pod_cidr           = var.network_plugin == "kubenet" ? var.ip_addresses.pod_cidr : null
    service_cidr       = var.ip_addresses.service_cidr
    load_balancer_sku  = var.load_balancer.sku

    dynamic "load_balancer_profile" {
      for_each = (var.load_balancer.sku == "Standard" && var.load_balancer.profile != null) ? [1] : []
      content {
        managed_outbound_ip_count = var.load_balancer.profile["managed_outbound_ip_count"]
        outbound_ip_prefix_ids    = var.load_balancer.profile["outbound_ip_prefix_ids"]
        outbound_ip_address_ids   = var.load_balancer.profile["outbound_ip_address_ids"]
      }
    }
  }

  addon_profile {
    aci_connector_linux {
      enabled     = var.aci_connector_linux.enabled
      subnet_name = var.aci_connector_linux.subnet_name
    }
    azure_policy {
      enabled = var.enable_azure_policy
    }
    http_application_routing {
      enabled = var.enable_http_application_routing
    }
    oms_agent {
      enabled                    = var.enable_log_analytics
      log_analytics_workspace_id = var.log_analytics_workspace
    }
  }

  lifecycle {
    ignore_changes = [windows_profile]
  }
}