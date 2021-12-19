variable "resource_group_name" {
  type = string
}

variable "aks_name" {
  type = string
}

variable "lock" {
  type = bool
  default = true
}

variable "default_tags" {
  type = object({
    ENV       = string
    Owner     = string
    CreatedBy = string
    Automated = bool
  })
}

variable "aks_extra_tags" {
  type    = map(string)
  default = {}
}

variable "nsg_extra_tags" {
  type    = map(string)
  default = {}
}

variable "vnet_extra_tags" {
  type    = map(string)
  default = {}
}

variable "api_server_authorized_ip_ranges" {
  type    = list(string)
  default = []
}

variable "aks_dns_prefix" {
  type    = string
  default = null
}

variable "enable_pod_security_policy" {
  type    = bool
  default = false
}

variable "kubernetes_version" {
  type    = string
  default = "1.19.3"
}

variable "node_resource_group" {
  type    = string
  default = null
}

variable "aks_location" {
  type    = string
  default = null
}

variable "default_node_pool_name" {
  type    = string
  default = null
}

variable "default_node_pool_core" {
  type = object({
    vm_size         = string
    os_disk_size_gb = number
    node_count      = number
  })
}

variable "default_node_pool_scale" {
  type = object({
    enable_auto_scaling = bool
    min_count           = number
    max_count           = number
  })
  default = {
    enable_auto_scaling = false
    min_count           = 1
    max_count           = 10
  }
}

variable "default_node_pool_max_pods" {
  type    = number
  default = 110
}

variable "default_node_pool_sla" {
  type = object({
    type               = string
    availability_zones = list(string)
  })
  default = {
    type               = "VirtualMachineScaleSets"
    availability_zones = []
  }
}

variable "role_based_access_control_enable" {
  type = bool
  default = true
}

variable "admin_group_ids" {
  type = list(string)
  default = []
}

variable "ip_addresses" {
  type = object({
    vnet_address_space    = list(string)
    subnet_address_prefix = string
    dns_service_ip        = string
    docker_bridge_cidr    = string
    pod_cidr              = string
    service_cidr          = string
  })

  default = {
    vnet_address_space    = ["172.0.0.0/16"]
    subnet_address_prefix = "172.0.0.0/18"
    docker_bridge_cidr    = "172.17.0.1/16"
    dns_service_ip        = "10.0.0.10"
    service_cidr          = "10.0.0.0/16"
    pod_cidr              = "10.240.0.0/16"
  }
}

//network profile
variable "network_plugin" {
  type    = string
  default = "azure"
}

variable "network_policy" {
  type    = string
  default = "azure"
}

variable "load_balancer" {
  type = object({
    sku = string
    profile = object({
      managed_outbound_ip_count = number
      outbound_ip_prefix_ids    = list(string)
      outbound_ip_address_ids   = list(string)
    })
  })

  default = {
    sku     = "Standard"
    profile = null
  }
}

//addon profile
variable "aci_connector_linux" {
  type = object({
    enabled     = bool
    subnet_name = string
  })

  default = {
    enabled     = false
    subnet_name = null
  }
}

variable "enable_azure_policy" {
  type    = bool
  default = false
}

variable "enable_http_application_routing" {
  type    = bool
  default = false
}

variable "enable_log_analytics" {
  type    = bool
  default = true
}

variable "log_analytics_workspace" {
  type = string
}

variable "datadog_enable" {
  type = bool
}

variable "datadog_enable_log" {
  type    = bool
  default = true
}

variable "datadog_enable_apm" {
  type    = bool
  default = true
}

variable "datadog_api_key" {
  type    = string
  default = ""
}

variable "aks_cluster_rolebindings" {
  type = map(object({
    name = string
    subjects = list(object({
      name = string
      kind = string
      id   = string
    }))
  }))
  default = {}
}

variable "aks_rolebindings" {
  type = map(object({
    name      = string
    kind      = string
    namespace = string
    subjects = list(object({
      name = string
      kind = string
      id   = string
    }))
  }))
  default = {}
}

variable "secrets_store_provider_enable" {
  type    = bool
  default = true
}

variable "debug" {
  type = map(string)

  default = {
    secret_store_provider = false
  }
}

variable "ingress_controller_enable" {
  type    = bool
  default = false
}

variable "nginx_ingress_name" {
  type    = string
  default = "nginx"
}

variable "ingress_controller_name" {
  type    = string
  default = "ingress-controller"
}

variable "ingress_controller_additional_parameters" {
  type    = map(any)
  default = {}
}

variable "ingress_controller_additional_string_parameters" {
  type    = map(any)
  default = {}
}

variable "external_dns_enable" {
  type    = bool
  default = false
}

variable "managed_dns_zone_id" {
  type    = string
  default = ""
}

variable "external_dns_owner_id" {
  type    = string
  default = ""
}

variable "external_dns_replicas" {
  type    = number
  default = 3
}

variable "external_dns_string_parameters" {
  type    = map(string)
  default = {}
}

variable "external_dns_additional_parameters" {
  type    = map(any)
  default = {}
}

variable "cert_manager_enable" {
  type    = bool
  default = false
}

variable "namespaces" {
  type = list(object({
    name        = string
    labels      = map(string)
    annotations = map(string)
    quotas = list(object({
      name        = string
      labels      = map(string)
      annotations = map(string)
      spec = object({
        hard   = map(string)
        scopes = list(string)
      })
    })),
    limit_range = object({
      name        = string
      labels      = map(string)
      annotations = map(string)
      limits      = map(map(map(string)))
    })
  }))
}

variable "kured_enable" {
  type    = bool
  default = true
}

variable "kured_period" {
  type    = string
  default = "1h0m0s"
}

variable "kured_reboot_days" {
  type    = list(string)
  default = ["sat", "sun"]
}

variable "kured_reboot_start_time" {
  type    = string
  default = "0:00"
}

variable "kured_reboot_end_time" {
  type    = string
  default = "23:59"
}

variable "kured_reboot_time_zone" {
  type    = string
  default = "UTC"
}

variable "twistlock_enable" {
  type    = bool
  default = true
}

variable "twistlock_username" {
  type    = string
  default = null
}

variable "twistlock_password" {
  type    = string
  default = null
}

variable "twistlock_defender_version" {
  type    = string
  default = "defender_20_04_177"
}

variable "twistlock_defender_namespace" {
  type    = string
  default = "twistlock"
}

variable "twistlock_defender_console_address" {
  type    = string
  default = ""
}