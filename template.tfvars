# [DO NOT CHANGE] : If you change property with the flag, there is risk that the resource will be destroyed and recreated.

#--------------------------------------------------------------
# Tags
#--------------------------------------------------------------

default_tags = {
  ENV       = "<environment>"
  Owner     = "<owner>"
  CreatedBy = "<createdby>"
  Automated = true
}

# Add your custom tags here
nsg_extra_tags = {}

vnet_extra_tags = {}

aks_extra_tags = {}

#--------------------------------------------------------------
# Resource Group
#--------------------------------------------------------------

/*** Parameters for resource group
 * - resource_group_name     : (string)[DO NOT CHANGE] The name of existed resource group which you want to provision AKS
***/
resource_group_name = "<name>"

#--------------------------------------------------------------
# Azure Kubernetes Cluster
#--------------------------------------------------------------

/*** Parameters
 * - aks_name                        : (string)[DO NOT CHANGE] The name of the Managed Kubernetes Cluster to create.
 * - api_server_authorized_ip_ranges : (string)The IP ranges to whitelist for incoming traffic to the masters.
***/
aks_name                        = "<aks_name>"
api_server_authorized_ip_ranges = []

/*** Parameters for role_based_access_control.
 * - role_based_access_control_enable = true           : (boolean)[DO NOT CHANGE] Is Role Based Access Control Enabled
 * - admin_group_ids : (list of string) The azure group object id which will be assigned as the admin group for cluster admin role
***/
role_based_access_control_enable = true
admin_group_ids                  = []

/*** Parameters for default_node_pool
 * - vm_size         : (string)[DO NOT CHANGE] The size of the Virtual Machine, such as Standard_DS2_v2. please refer to https://docs.microsoft.com/en-us/azure/virtual-machines/linux/sizes to obtain your own type.
 * - os_disk_size_gb : (number)[DO NOT CHANGE] The size of the OS Disk which should be used for each agent in the Node Pool.
 * - node_count      : (number) The initial number of nodes which should exist in this Node Pool. If specified this must be between 1 and 100 and between min_count and max_count.
***/
default_node_pool_core = {
  vm_size         = "Standard_D2_v2"
  os_disk_size_gb = 100
  node_count      = 3
}

/*** Parameters for log_analytics_workspace
 * - log_analytics_workspace : (string) The ID of the Log Analytics Workspace which the OMS Agent should send data to. Must be present if enabled is true.
***/
log_analytics_workspace = "<log_analytics_workspace_id>"

/*** Parameters to configure ClusterRoleBindings in the AKS cluster
 * - (map key)   : (string) The key of the map is the name of the ClusterRoleBinding resource.
 * - (map value) : (object) The detail configuration of the ClusterRoleBinding.
 *   - name      : (string) The name of the ClusterRole, e.g., cluster-admin, edit.
 *   - subjects  : (list) The subjects of the ClusterRoleBinding.
 *     - kind    : (string) The kind of the subject, usually User or Group.
 *     - name    : (string) The name of the subject, can be a user email or group object id.
 *     - id      : (string) The object id of the subject.
***/
aks_cluster_rolebindings = {
  "<name_of_cluster_rolebindings>" = {
    name = "<role_name>"
    subjects = [
      {
        kind = "User"
        name = "<subject_name>"
        id   = "<object_id>"
      }
    ]
  }
}

/*** Parameters to configure RoleBindings in the AKS cluster
 * - (map key)   : (string) The key of the map is the name of the RoleBinding resource.
 * - (map value) : (object) The detail configuration of the RoleBinding.
 *   - name      : (string) The name of the Role or ClusterRole, e.g., admin, edit.
 *   - kind      : (string) The kind of the RoleBinding. Can be either Role or ClusterRole.
 *   - namespace : (string) The namespace of the Role.
 *   - subjects  : (list) The subjects of the RoleBinding.
 *     - kind    : (string) The kind of the subject, usually User or Group.
 *     - name    : (string) The name of the subject, can be a user email or group object id.
 *     - id      : (string) The object id of the subject.
***/
aks_rolebindings = {
  "<name_of_rolebindings>" = {
    name      = "<role_name>"
    kind      = "ClusterRole"
    namespace = "<namespace>"
    subjects = [
      {
        kind = "User"
        name = "<subject_name>"
        id   = "<object_id>"
      }
    ]
  }
}

namespaces = []
