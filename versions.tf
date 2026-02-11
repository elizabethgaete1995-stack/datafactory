/* terraform {
  required_version = ">= 1.3.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.80.0"
    }
  }
}
*/
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0" # o fija la versión que uses en tu org
    }
  }
}

provider "azurerm" {
  subscription_id            = var.subscriptionid
  tenant_id                  = var.tenantid
  skip_provider_registration = true


  features {}
}
