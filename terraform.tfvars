#####################################
# Tags estándar (obligatorios)
#####################################

entity        = "ClaroChile"
environment   = "dev"          # dev | pre | pro
app_name      = "esim-datafactory"
cost_center   = "CC-IT-001"
tracking_code = "PRJ-ESIM-2026"

#####################################
# Resource Group / Ubicación
#####################################

rsg_name      = "rg-poc-test-001"
location      = "chilecentral"
subscriptionid = "ef0a94be-5750-4ef8-944b-1bbc0cdda800"

#####################################
# Data Factory
#####################################

adf_name                          = "cl-adf-dev-esim-01"
adf_vnet_enabled                  = true
adf_public_network_access_enabled = false

#####################################
# Git Integration (opcional)
#####################################

enable_github   = false
account_name    = "claro-devops"
branch_name     = "main"
git_url         = "https://github.com/claro/esim-adf"
repository_name = "esim-adf"
root_folder     = "/"

#####################################
# Key Vault / CMK (opcional)
#####################################

key_exist          = false
key_custom_enabled = true
key_name           = "cl-adf-dev-key"
akv_name           = "akvchilecentralakvdev001"
uai_name           = "cl-uai-adf-dev-01"
inherit            = true

#####################################
# Log Analytics / Diagnostics
#####################################

lwk_name                              = "lwkchilecentrallwkdev001"
lwk_rsg_name                          = "rg-poc-test-001"
analytics_diagnostic_monitor_enabled  = true
analytics_diagnostic_monitor_name     = "adf-diagnostic-setting"

template_adanalytics_name = "adf-analytics-deployment"

#####################################
# Identidades adicionales (si aplica)
#####################################

identity_list = []

#####################################
# Tags adicionales opcionales
#####################################

custom_tags = {
  owner          = "plataforma-data"
  technical_area = "integration"
  compliance     = "internal"
}