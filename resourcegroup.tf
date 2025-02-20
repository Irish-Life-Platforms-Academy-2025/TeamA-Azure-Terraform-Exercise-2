resource "azurerm_resource_group" "rg" {
  name = "${var.name}-${var.environment}-rg"
  location = var.location
}