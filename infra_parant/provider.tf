terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.32.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "d2df2a41-202d-4062-831a-7223cf0df18f"
}