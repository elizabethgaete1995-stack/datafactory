# Azure Data Factory - Golden Module (Curated)

Módulo Terraform para desplegar **Azure Data Factory** con:
- Tags estándar multi-cliente: `entity`, `environment`, `app_name`, `cost_center`, `tracking_code`
- Opción de heredar tags del Resource Group (`inherit`)
- Integración opcional con **CMK** (Key Vault + UAI + Access Policy + Key)
- Linked Service a Key Vault (si aplica)
- Deploy de **ADF Analytics** vía ARM template
- Diagnostic Settings hacia Log Analytics (opcional)

## Tags

El módulo aplica siempre:
- Standard tags: `entity`, `environment`, `app_name`, `cost_center`, `tracking_code`
- Tag interno: `hidden-deploy=curated`
- `custom_tags` (opcional)

Si `inherit=true`, mezcla además los tags existentes del Resource Group.

## Features (flags)

| Feature | Variable(s) |
|---|---|
| CMK | `key_exist` o `key_custom_enabled` |
| Diagnostics | `analytics_diagnostic_monitor_enabled` |
| GitHub config | `enable_github` |

> El módulo valida variables dependientes (fail-fast).  
> Ej: si CMK está habilitado, exige `akv_name`, `key_name`, `uai_name`.

## Ejemplo rápido

```hcl
module "adf" {
  source = "../.."

  entity        = "ClaroChile"
  environment   = "pre"
  app_name      = "synapticore"
  cost_center   = "CC12345"
  tracking_code = "PRJ-ESIM-001"

  custom_tags = {
    owner = "data-team"
  }

  rsg_name       = "rg-pre-data-001"
  location       = "eastus2"
  subscriptionid = "00000000-0000-0000-0000-000000000000"
  inherit        = true

  adf_name                          = "adf-pre-synapticore-001"
  adf_vnet_enabled                  = true
  adf_public_network_access_enabled = false

  # CMK (opcional)
  key_custom_enabled = true
  key_exist          = true
  akv_name           = "kv-pre-data-001"
  key_name           = "cmk-adf"
  uai_name           = "uai-pre-adf-cmk-001"

  # Diagnostics (opcional)
  analytics_diagnostic_monitor_enabled = true
  lwk_name                              = "law-pre-core-001"
  lwk_rsg_name                           = "rg-pre-monitor-001"
}
```

## Estructura esperada

- `scripts/arm/analytics.json` debe existir dentro del módulo (tal como en tu repo actual).

## Outputs

- `adf_id`, `adf_name`
- `uai_id` (si aplica)
- `cmk_key_id` (si aplica)
