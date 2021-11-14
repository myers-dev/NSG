resource "azurerm_route_table" "RT" {
  name                          = "RT"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  disable_bgp_route_propagation = false

  route {
    name           = "route1"
    address_prefix = "5.5.5.5/32"
    next_hop_type  = "VirtualAppliance"
    next_hop_in_ip_address = "10.1.0.100"
  }
}

resource "azurerm_subnet_route_table_association" "RTASSOCIATION" {
  count = 0
  subnet_id      = module.vnet[1].vnet_subnets[0]
  route_table_id = azurerm_route_table.RT.id
}