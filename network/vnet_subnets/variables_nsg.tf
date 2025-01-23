# Network Security Group definition

# Custom security rules
# [name, priority, direction, access, protocol, source_port_range, destination_port_range, description]"
# All the fields are required.
variable "destination_address_prefix" {
  type        = list(string)
  default     = ["*"]
  description = "Destination address prefix to be applied to all predefined rules. list(string) only allowed one element (CIDR, `*`, source IP range or Tags). Example [\"10.0.3.0/24\"] or [\"VirtualNetwork\"]"
}

variable "destination_address_prefixes" {
  type        = list(string)
  default     = null
  description = "Destination address prefix to be applied to all predefined rules. Example [\"10.0.3.0/32\",\"10.0.3.128/32\"]"
}

variable "rules_by_subnet" {
  type        = list(object({
    tier_name = string
    subnet_name = string
    predefined_rules = list(object({
      name = string
      priority = number
      source_port_range = string
    }))
    custom_rules = list(object({
      name = string
      priority = number
      direction = string
      access = string
      protocol = string
      source_port_range = string
      destination_port_range = string
      source_address_prefix = optional(string)
      destination_address_prefix = optional(string)
      source_app_layer_name = optional(string)
      destination_app_layer_name = optional(string)
      description = string
    }))
  }))
  description = "Resource group name"
}

variable "app_layers" {
  type = list(object({
    layer_name = string
  }))
}