variable "rg" {
  type        = string
  default     = "josh-nenad-Terraform-rg"
  description = "Name for resource group"
}

variable "name" {
  type        = string
  default     = "teamA"
  description = "Name for resource"
}

variable "subnet" {
  type        = string
  default     = "subnet"
  description = "Name for subnets"
}

variable "location" {
  type        = string
  default     = "eastus"
  description = "Azure Location of resources"
}