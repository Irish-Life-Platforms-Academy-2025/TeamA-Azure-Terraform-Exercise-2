terraform {
  #Use a Terraform backend to store the .tfstate in an Azure Storage Account
  backend "azurerm" {
    resource_group_name  = "TeamA-Staging-RG"
    storage_account_name = "teamastoraccount"
    container_name       = "tfstate"
    key                  = "excercise2.tfstate"
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