variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "westeurope"
}

variable "project_name" {
  description = "Project short name"
  type        = string
  default     = "test"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "lab"
}

variable "vnet_cidr" {
  description = "CIDR for VNet"
  type        = string
  default     = "10.10.0.0/16"
}

variable "aks_subnet_cidr" {
  description = "CIDR for AKS subnet"
  type        = string
  default     = "10.10.1.0/24"
}

variable "postgres_subnet_cidr" {
  description = "CIDR for PostgreSQL subnet"
  type        = string
  default     = "10.10.2.0/24"
}

variable "aks_kubernetes_version" {
  description = "AKS Kubernetes version"
  type        = string
  default     = null
}

variable "system_node_vm_size" {
  type    = string
  default = "Standard_B2s"
}

variable "app_node_vm_size" {
  type    = string
  default = "Standard_B2s"
}

variable "monitor_node_vm_size" {
  type    = string
  default = "Standard_B2s"
}

variable "system_node_count" {
  type    = number
  default = 1
}

variable "app_node_min_count" {
  type    = number
  default = 1
}

variable "app_node_max_count" {
  type    = number
  default = 2
}

variable "monitor_node_min_count" {
  type    = number
  default = 1
}

variable "monitor_node_max_count" {
  type    = number
  default = 2
}

variable "postgres_admin_username" {
  type    = string
  default = "pgadmin"
}

variable "postgres_admin_password" {
  description = "PostgreSQL admin password"
  type        = string
  sensitive   = true
}

variable "postgres_sku_name" {
  type    = string
  default = "B_Standard_B1ms"
}

variable "postgres_storage_mb" {
  type    = number
  default = 32768
}

variable "postgres_version" {
  type    = string
  default = "16"
}

variable "tags" {
  type = map(string)
  default = {
    owner       = "me"
    environment = "lab"
    managed_by  = "terraform"
  }
}