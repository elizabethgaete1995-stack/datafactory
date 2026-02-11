############################################
# Standard tags (obligatorios)
############################################
variable "entity" {
  description = "Nombre del cliente."
  type        = string
}

variable "environment" {
  description = "Ambiente: dev, pre, pro."
  type        = string
  validation {
    condition     = contains(["dev", "pre", "pro"], lower(var.environment))
    error_message = "environment debe ser: dev, pre o pro."
  }
}

variable "app_name" {
  description = "Nombre de la aplicación."
  type        = string
}

variable "cost_center" {
  description = "Identificador del centro de costo."
  type        = string
}

variable "tracking_code" {
  description = "Nombre/código del proyecto."
  type        = string
}

variable "custom_tags" {
  description = "Tags adicionales."
  type        = map(string)
  default     = {}
}

############################################
# Resource Group / Location / Subscription
############################################
variable "rsg_name" {
  description = "Nombre del Resource Group donde se despliega."
  type        = string
}

variable "location" {
  description = "Azure region donde se despliega (ej: eastus2, brazilsouth)."
  type        = string
}

variable "subscriptionid" {
  description = "Subscription ID destino."
  type        = string
}

variable "tenantid" {
  description = "Tenant ID destino."
  type        = string
}

variable "inherit" {
  description = "Si true, hereda tags del Resource Group y los mezcla con standard + custom."
  type        = bool
  default     = true
}

############################################
# Data Factory
############################################
variable "adf_name" {
  description = "Nombre del Azure Data Factory."
  type        = string
}

variable "adf_vnet_enabled" {
  description = "Habilita Managed VNET en ADF."
  type        = bool
  default     = false
}

variable "adf_public_network_access_enabled" {
  description = "Habilita acceso por red pública (public network)."
  type        = bool
  default     = true
}

############################################
# CMK / Key Vault (opcional)
############################################
variable "key_exist" {
  description = "Indica si la Key ya existe en el Key Vault."
  type        = bool
  default     = false
}

variable "key_custom_enabled" {
  description = "Habilita CMK por configuración explícita."
  type        = bool
  default     = false
}

variable "akv_name" {
  description = "Nombre del Key Vault donde está/estará la Key (solo si CMK aplica)."
  type        = string
  default     = null
  validation {
    condition     = !(var.key_exist || var.key_custom_enabled) || (try(length(var.akv_name), 0) > 0)
    error_message = "akv_name es requerido cuando CMK está habilitado (key_exist=true o key_custom_enabled=true)."
  }
}

variable "key_vault_id" {  
  description = "El ID del Key Vault donde se almacena la clave"  
  type        = string  
} 

variable "key_name" {
  description = "Nombre de la Key en el Key Vault (solo si CMK aplica)."
  type        = string
  default     = null
  validation {
    condition     = !(var.key_exist || var.key_custom_enabled) || (try(length(var.key_name), 0) > 0)
    error_message = "key_name es requerido cuando CMK está habilitado (key_exist=true o key_custom_enabled=true)."
  }
}

variable "uai_name" {
  description = "Nombre de la User Assigned Identity para CMK (solo si CMK aplica)."
  type        = string
  default     = null
  validation {
    condition     = !(var.key_exist || var.key_custom_enabled) || (try(length(var.uai_name), 0) > 0)
    error_message = "uai_name es requerido cuando CMK está habilitado (key_exist=true o key_custom_enabled=true)."
  }
}

variable "identity_list" {
  description = "Lista de IDs de identidades (UAI) a asociar a ADF cuando corresponda."
  type        = list(string)
  default     = []
}

############################################
# GitHub configuration (opcional)
############################################
variable "enable_github" {
  description = "Habilita la configuración de GitHub en ADF."
  type        = bool
  default     = false
}

variable "account_name" {
  description = "Cuenta de GitHub (user u org)."
  type        = string
  default     = null
  validation {
    condition     = !var.enable_github || (try(length(var.account_name), 0) > 0)
    error_message = "account_name es requerido cuando enable_github=true."
  }
}

variable "branch_name" {
  description = "Branch por defecto."
  type        = string
  default     = null
  validation {
    condition     = !var.enable_github || (try(length(var.branch_name), 0) > 0)
    error_message = "branch_name es requerido cuando enable_github=true."
  }
}

variable "git_url" {
  description = "URL Git (ej: https://github.com)."
  type        = string
  default     = null
  validation {
    condition     = !var.enable_github || (try(length(var.git_url), 0) > 0)
    error_message = "git_url es requerido cuando enable_github=true."
  }
}

variable "repository_name" {
  description = "Nombre del repo."
  type        = string
  default     = null
  validation {
    condition     = !var.enable_github || (try(length(var.repository_name), 0) > 0)
    error_message = "repository_name es requerido cuando enable_github=true."
  }
}

variable "root_folder" {
  description = "Carpeta raíz en el repo."
  type        = string
  default     = "/"
}

############################################
# Log Analytics + Diagnostic Settings (opcional)
############################################
variable "analytics_diagnostic_monitor_enabled" {
  description = "Habilita Diagnostic Settings hacia Log Analytics."
  type        = bool
  default     = false
}

variable "analytics_diagnostic_monitor_name" {
  description = "Nombre del Diagnostic Setting."
  type        = string
  default     = "adf-diag"
}

variable "lwk_name" {
  description = "Nombre del Log Analytics Workspace."
  type        = string
  default     = null
  validation {
    condition     = !var.analytics_diagnostic_monitor_enabled || (try(length(var.lwk_name), 0) > 0)
    error_message = "lwk_name es requerido cuando analytics_diagnostic_monitor_enabled=true."
  }
}

variable "lwk_rsg_name" {
  description = "Resource Group del Log Analytics Workspace."
  type        = string
  default     = null
  validation {
    condition     = !var.analytics_diagnostic_monitor_enabled || (try(length(var.lwk_rsg_name), 0) > 0)
    error_message = "lwk_rsg_name es requerido cuando analytics_diagnostic_monitor_enabled=true."
  }
}

############################################
# ARM Template Deployment (ADF Analytics)
############################################
variable "template_adanalytics_name" {
  description = "Nombre del deployment ARM para ADF Analytics."
  type        = string
  default     = "ADAnalytics"
}
