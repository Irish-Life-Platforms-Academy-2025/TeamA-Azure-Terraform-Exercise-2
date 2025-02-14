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

variable "location" {
    type = string
    description = "Azure default location."
    default= "eastus"
}

    variable "private_vnet_cidr" {
        type = string
        description = "Private VNet address space (CIDR notation)"
        default = "10.20.0.0/16"
}
    variable "public_vnet_cidr" {
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