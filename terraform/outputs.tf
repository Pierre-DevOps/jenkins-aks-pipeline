# ===========================================
# OUTPUTS RESOURCE GROUP
# ===========================================

output "resource_group_name" {
  description = "Nom du Resource Group créé"
  value       = azurerm_resource_group.main.name
}

output "resource_group_location" {
  description = "Région du Resource Group"
  value       = azurerm_resource_group.main.location
}

# ===========================================
# OUTPUTS RÉSEAU
# ===========================================

output "vnet_name" {
  description = "Nom du Virtual Network"
  value       = azurerm_virtual_network.main.name
}

output "vnet_id" {
  description = "ID du Virtual Network"
  value       = azurerm_virtual_network.main.id
}

output "subnet_nodes_id" {
  description = "ID du subnet pour les nodes AKS"
  value       = azurerm_subnet.nodes.id
}

output "subnet_pods_id" {
  description = "ID du subnet pour les pods AKS"
  value       = azurerm_subnet.pods.id
}

output "nsg_id" {
  description = "ID du Network Security Group"
  value       = azurerm_network_security_group.aks.id
}

# ===========================================
# OUTPUTS AKS
# ===========================================

output "aks_cluster_name" {
  description = "Nom du cluster AKS"
  value       = azurerm_kubernetes_cluster.main.name
}

output "aks_cluster_id" {
  description = "ID du cluster AKS"
  value       = azurerm_kubernetes_cluster.main.id
}

output "aks_cluster_fqdn" {
  description = "FQDN du cluster AKS"
  value       = azurerm_kubernetes_cluster.main.fqdn
}

output "aks_kubernetes_version" {
  description = "Version de Kubernetes déployée"
  value       = azurerm_kubernetes_cluster.main.kubernetes_version
}

output "aks_node_resource_group" {
  description = "Nom du Resource Group des nodes AKS (géré par Azure)"
  value       = azurerm_kubernetes_cluster.main.node_resource_group
}

output "aks_identity_principal_id" {
  description = "Principal ID de l'identité managée AKS"
  value       = azurerm_kubernetes_cluster.main.identity[0].principal_id
}

# ===========================================
# OUTPUTS KEY VAULT
# ===========================================

output "key_vault_name" {
  description = "Nom du Key Vault"
  value       = azurerm_key_vault.main.name
}

output "key_vault_id" {
  description = "ID du Key Vault"
  value       = azurerm_key_vault.main.id
}

output "key_vault_uri" {
  description = "URI du Key Vault"
  value       = azurerm_key_vault.main.vault_uri
}

# ===========================================
# OUTPUTS LOG ANALYTICS
# ===========================================

output "log_analytics_workspace_name" {
  description = "Nom du workspace Log Analytics"
  value       = azurerm_log_analytics_workspace.main.name
}

output "log_analytics_workspace_id" {
  description = "ID du workspace Log Analytics"
  value       = azurerm_log_analytics_workspace.main.id
}

# ===========================================
# OUTPUTS CONNEXION KUBECTL
# ===========================================

output "kube_config_command" {
  description = "Commande pour configurer kubectl"
  value       = "az aks get-credentials --resource-group ${azurerm_resource_group.main.name} --name ${azurerm_kubernetes_cluster.main.name}"
}