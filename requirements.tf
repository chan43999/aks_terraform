terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=2.32.0"
    }
    azuread = {
      source = "hashicorp/azuread"
      version = "=0.8.0"
    }
    null = {
      version = "=2.1.2"
    }
  }
}