location = "eastus"

resource_group_name = "NSG"

tags = {
    Terraform   = "true"
    Environment = "dev"
} 
    
lock_level = ""

security_group_name = "nsg"

custom_rules = [
  {
    name                   = "ssh"
    priority               = 200
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "tcp"
    source_port_range      = "*"
    destination_port_range = "22"
    source_address_prefix  = "8.8.8.8/32"
    description            = "ssh"
  },

]

vnets = [   
          { 
            name = "hub"
            address_space = ["10.1.0.0/16"]
            subnet_names = [ "default" ]
            subnet_prefixes = [ "10.1.0.0/24" ]
            },
            {
            name = "spoke"
            address_space = ["10.0.0.0/16"]
            subnet_names = [ "default" ]
            subnet_prefixes = [ "10.0.0.0/24" ]
            }
        ]            
 




