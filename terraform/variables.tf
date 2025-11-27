# ===========================================
# VARIABLES GÉNÉRALES
# ===========================================

variable "project_name" {
  description = "Nom du projet (utilisé comme préfixe pour les ressources)"
  type        = string
}

variable "environment" {
  description = "Environnement de déploiement (dev, staging, prod)"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "L'environnement doit être dev, staging ou prod."
  }
}

variable "location" {
  description = "Région Azure pour le déploiement"
  type        = string
  default     = "switzerlandnorth"
}

variable "tags" {
  description = "Tags communs à appliquer sur toutes les ressources"
  type        = map(string)
  default     = {}
}

# ===========================================
# VARIABLES RÉSEAU
# ===========================================

variable "vnet_address_space" {
  description = "Plage d'adresses IP du Virtual Network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_nodes_prefix" {
  description = "Plage d'adresses pour le subnet des nodes AKS"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet_pods_prefix" {
  description = "Plage d'adresses pour le subnet des pods AKS"
  type        = string
  default     = "10.0.2.0/24"
}

variable "authorized_ip_ranges" {
  description = "Liste des IPs autorisées à accéder à l'API Server AKS"
  type        = list(string)
  default     = []
}

# ===========================================
# VARIABLES AKS
# ===========================================

variable "kubernetes_version" {
  description = "Version de Kubernetes pour le cluster AKS"
  type        = string
  default     = "1.31"
}

variable "node_count" {
  description = "Nombre initial de nodes dans le pool par défaut"
  type        = number
  default     = 2
}

variable "node_vm_size" {
  description = "Taille des VMs pour les nodes AKS"
  type        = string
  default     = "Standard_DS2_v2"
}

variable "node_min_count" {
  description = "Nombre minimum de nodes (autoscaling)"
  type        = number
  default     = 1
}

variable "node_max_count" {
  description = "Nombre maximum de nodes (autoscaling)"
  type        = number
  default     = 5
}

variable "node_os_disk_size_gb" {
  description = "Taille du disque OS des nodes en GB"
  type        = number
  default     = 50
}

# ===========================================
# VARIABLES KEY VAULT
# ===========================================

variable "key_vault_sku" {
  description = "SKU du Key Vault (standard ou premium)"
  type        = string
  default     = "standard"
  validation {
    condition     = contains(["standard", "premium"], var.key_vault_sku)
    error_message = "Le SKU doit être standard ou premium."
  }
}

variable "soft_delete_retention_days" {
  description = "Nombre de jours de rétention pour le soft delete du Key Vault"
  type        = number
  default     = 30
}

# ===========================================
# VARIABLES LOG ANALYTICS
# ===========================================

variable "log_analytics_sku" {
  description = "SKU du workspace Log Analytics"
  type        = string
  default     = "PerGB2018"
}

variable "log_retention_days" {
  description = "Durée de rétention des logs en jours"
  type        = number
  default     = 30
}