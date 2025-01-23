

locals {
    #nsg_types = ["enterprise", "private", "public", "dmz", "central_ingress", "central_egress"]
    ngs_versions = ["ga"] #alpha, beta
    
    nsg_type_versions = flatten([
        for subnet in var.subnet_config : [
            for version in local.ngs_versions : {
                    key = "${subnet.subnet_type}-${subnet.subnet_postfix}-${version}"
                    name = "${subnet.subnet_type}-${subnet.subnet_postfix}-${version}"
                    type = subnet.subnet_type
                    subnet   = subnet
                    version = version
                }
            ]
    ])

    nsg_type_version_data = {
        for item in local.nsg_type_versions : item.name => {
                key = item.key
                name = item.name
                subnet = item.subnet
                version = item.version
                content = jsondecode(data.local_file.rule_json_file["${item.key}"].content)
            }
    }

    rules_by_subnet = {
        for item in var.rules_by_subnet : item.subnet_name => {
                subnet_name = item.subnet_name
                predefined_rules = item.predefined_rules
                custom_rules = item.custom_rules
            }
    }

    app_layer_ids = {
        for item in var.app_layers : item.layer_name => azurerm_application_security_group.app_security_groups[item.layer_name].id
    }
}