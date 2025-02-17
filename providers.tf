terraform {
  required_version = ">= 1.9.6"
  #Use a Terraform backend to store the .tfstate in an Azure Storage Account
  backend "azurerm" {
    resource_group_name  = "TeamA-rg"
    storage_account_name = "teamastorageaccount"
    container_name       = "teamablobcontainer"
    key                  = "acr-terraform.teamablobcontainer"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.3.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "168b5162-e625-42f1-994a-dfcfff0433bb"

}