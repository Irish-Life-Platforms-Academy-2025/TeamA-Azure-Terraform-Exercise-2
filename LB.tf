# Public IP for Load Balancer
resource  "azurerm_public_ip" "TeamA_Public_IP" {
	name = "${var.name}-PublicIP"
	location = var.location
	resource_group_name = var.rg
	allocation_method = "Static"
}

# Load Balancer w/ Zone Redundancy
resource "azurerm_lb" "TeamA_LB" {
	name = "${var.name}-lb"
	location = var.location
	resource_group_name = var.rg
	sku = "Standard" #Standard SKU for zone redundancy

# Fronted IP config
		frontend_ip_configuration {
		name = "${var.name}-fe-ip"
		public_ip_address_id = azurerm_public_ip.TeamA_Public_IP.id
	}
		}
# Backend Pool for Load Balancer w/ Zone Redundancy
resource "azurerm_lb_backend_address_pool" "TeamA_LB_address_pool" {
	name = "BackEndAddressPool"
	loadbalancer_id = azurerm_lb.TeamA_LB.id
}

# Associate VM1 NIC to LB Backend address pool
resource "azurerm_network_interface_backend_address_pool_association" "NIC-BE-VM1" {
  network_interface_id    = azurerm_network_interface.teamA-nic1.id
  backend_address_pool_id = azurerm_lb_backend_address_pool.TeamA_LB_address_pool.id
  ip_configuration_name   = "internal"
}

# Associate VM2 NIC to LB Backend address pool
resource "azurerm_network_interface_backend_address_pool_association" "NIC-BE-VM2" {
  network_interface_id    = azurerm_network_interface.teamA-nic2.id
  backend_address_pool_id = azurerm_lb_backend_address_pool.TeamA_LB_address_pool.id
  ip_configuration_name   = "internal"
}

# Health Probe for Load Balancer
resource "azurerm_lb_probe" "TeamA_LB-HP" {
	name = "${var.name}-health-probe"
	loadbalancer_id = azurerm_lb.TeamA_LB
	protocol = "Tcp"
	port = 80
	interval_in_seconds = 15
	number_of_probes = 2
}
# Load Balancer Rule
resource "azurern_lb_rule" "TeamA_LB_Rule" {
	name = "${var.name}-lb-rule"
	loadbalancer_id = azurerm_lb.TeamA_LB
	frontend_ip_configuration_name = "${var.name}-fe-ip"
	backend_address_pool_id = azure_lb.TeamA_LB.backend_address_pool.TeamA_LB_address_pool.id
	probe_id = azurerm_lb_TeamA_LB.probe.TeamA_LB-HP.id
	protocol = "Tcp"
	frontend_port = 80
	backend_port = 80
}


# Print the public ip address of the Load Balancer

output "public_ip" {
	value = azurerm_public_ip.TeamA_Public_IP.ip_address
}