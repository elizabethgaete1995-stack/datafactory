output "adf_id" {
  description = "ID del Azure Data Factory."
  value       = azurerm_data_factory.adf.id
}

output "adf_name" {
  description = "Nombre del Azure Data Factory."
  value       = azurerm_data_factory.adf.name
}

output "uai_id" {
  description = "ID de la User Assigned Identity usada para CMK (si aplica)."
  value       = local.key_cmk ? azurerm_user_assigned_identity.uai[0].id : null
}

output "cmk_key_id" {
  description = "ID de la Key usada para CMK (si aplica)."
  value       = local.key_cmk ? data.azurerm_key_vault_key.key_principal[0].id : null
}
