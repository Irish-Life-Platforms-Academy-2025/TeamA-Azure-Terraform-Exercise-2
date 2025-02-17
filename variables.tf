variable "rg" {
  type        = string
  default     = "TeamA-rg"
  description = "Name for resource group"
}

variable "name" {
  type        = string
  default     = "teamA"
  description = "Name for resource"
}

variable "location" {
    type = string
    description = "Azure default location."
    default= "eastus"
}

variable "password" {
  type        = string
  description = "The password for the local account that will be created on the new VM."
  default     = "P@$$w0rd1234!"
}

variable "vm_size" {
  type = string
  default = "Standard_D2s_v3"
}

variable "username" {
  type        = string
  description = "The username for the local account that will be created on the new VM."
  default     = "azureadmin"
}

variable "public_vnet_cidr" {
    type = string
    description = "Private VNet address space (CIDR notation)"
    default = "10.20.0.0/16"
}

variable "Private_vnet_cidr" {
    type = string
    description = "Public VNet address space (CIDR notation)"
    default = "10.30.0.0/16"
}

variable "private-subnet" {
  type        = string
  default     = "private-subnet"
  description = "Name for private subnets"
}

variable "public-subnet" {
  type        = string
  default     = "public-subnet"
  description = "Name for public subnets"
}