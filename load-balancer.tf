# Public IP for Load Balancer
resource  "azurerm_public_ip" "Public_IP" {
	name = "${var.name}-${var.environment}-PublicIP"
	location = azurerm_resource_group.rg.location
	resource_group_name = azurerm_resource_group.rg.name
	allocation_method = "Static"
}

# Load Balancer w/ Zone Redundancy
resource "azurerm_lb" "LB" {
	name = "${var.name}-${var.environment}-lb"
	location = azurerm_resource_group.rg.location
	resource_group_name = azurerm_resource_group.rg.name
	sku = "Standard" #Standard SKU for zone redundancy

# Fronted IP config
		frontend_ip_configuration {
		name = "${var.name}-${var.environment}-fe-ip"
		public_ip_address_id = azurerm_public_ip.Public_IP.id
	}
		}
# Backend Pool for Load Balancer w/ Zone Redundancy
resource "azurerm_lb_backend_address_pool" "LB_address_pool" {
	name = "BackEndAddressPool"
	loadbalancer_id = azurerm_lb.LB.id
}

# Associate VM1 NIC to LB Backend address pool
resource "azurerm_network_interface_backend_address_pool_association" "NIC-BE-VM1" {
  network_interface_id    = azurerm_network_interface.nic1.id
  backend_address_pool_id = azurerm_lb_backend_address_pool.LB_address_pool.id
  ip_configuration_name   = "${var.name}-${var.environment}-nic1-config"
}

# Associate VM2 NIC to LB Backend address pool
resource "azurerm_network_interface_backend_address_pool_association" "NIC-BE-VM2" {
  network_interface_id    = azurerm_network_interface.nic2.id
  backend_address_pool_id = azurerm_lb_backend_address_pool.LB_address_pool.id
  ip_configuration_name   = "${var.name}-${var.environment}-nic2-config"
}

# Health Probe for Load Balancer
resource "azurerm_lb_probe" "LB-HP" {
	name = "${var.name}-${var.environment}-health-probe"
	loadbalancer_id = azurerm_lb.LB.id
	protocol = "Tcp"
	port = 80
	interval_in_seconds = 15
	number_of_probes = 2
}
# Load Balancer Rule
resource "azurerm_lb_rule" "LB_Rule" {
	name = "${var.name}-${var.environment}-lb-rule"
	loadbalancer_id = azurerm_lb.LB.id
	frontend_ip_configuration_name = "${var.name}-${var.environment}-fe-ip"
	backend_address_pool_ids = [azurerm_lb_backend_address_pool.LB_address_pool.id]
	probe_id = azurerm_lb_probe.LB-HP.id
	protocol = "Tcp"
	frontend_port = 80
	backend_port = 80
}


# Print the public ip address of the Load Balancer

output "public_ip" {
	value = azurerm_public_ip.Public_IP.ip_address
}