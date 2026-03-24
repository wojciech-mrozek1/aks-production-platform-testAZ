resource "azurerm_log_analytics_workspace" "this" {
  name                = "law-${local.prefix}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = local.common_tags
}

resource "azurerm_kubernetes_cluster" "this" {
  name                = "aks-${local.prefix}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  dns_prefix          = "aks-${local.prefix}"

  kubernetes_version = var.aks_kubernetes_version
  sku_tier           = "Free"

  private_cluster_enabled             = true
  private_cluster_public_fqdn_enabled = false
  role_based_access_control_enabled   = true

  default_node_pool {
    name                         = "system"
    vm_size                      = var.system_node_vm_size
    node_count                   = var.system_node_count
    vnet_subnet_id               = azurerm_subnet.aks.id
    auto_scaling_enabled         = false
    type                         = "VirtualMachineScaleSets"
    only_critical_addons_enabled = true
    temporary_name_for_rotation  = "systmp"
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"
    load_balancer_sku = "standard"
    outbound_type     = "loadBalancer"
  }

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
  }

  tags = local.common_tags
}

resource "azurerm_kubernetes_cluster_node_pool" "app" {
  name                  = "apppool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.this.id
  vm_size               = var.app_node_vm_size
  vnet_subnet_id        = azurerm_subnet.aks.id
  mode                  = "User"

  auto_scaling_enabled = true
  min_count            = var.app_node_min_count
  max_count            = var.app_node_max_count

  node_taints = [
    "workload=app:NoSchedule"
  ]

  tags = local.common_tags
}

resource "azurerm_kubernetes_cluster_node_pool" "monitor" {
  name                  = "monpool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.this.id
  vm_size               = var.monitor_node_vm_size
  vnet_subnet_id        = azurerm_subnet.aks.id
  mode                  = "User"

  auto_scaling_enabled = true
  min_count            = var.monitor_node_min_count
  max_count            = var.monitor_node_max_count

  node_taints = [
    "workload=monitoring:NoSchedule"
  ]

  tags = local.common_tags
}

resource "azurerm_role_assignment" "aks_to_acr" {
  principal_id                     = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.this.id
  skip_service_principal_aad_check = true
}