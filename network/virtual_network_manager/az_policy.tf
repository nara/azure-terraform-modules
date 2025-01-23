resource "azurerm_policy_definition" "network_group_policy" {
  name         = "acceptanceTestPolicyDefinition"
  policy_type  = "Custom"
  mode         = "Microsoft.Network.Data"
  display_name = "acceptance test policy definition"
  management_group_id = var.management_group_id
  
  metadata = jsonencode({
        "category": "General"
    })


  policy_rule = jsonencode({
        "if": {
            "allOf": [
                {
                "field": "type",
                "equals": "Microsoft.Network/virtualNetworks"
                },
                {
                    "field": "tags['${var.tagName}']",
                    "in": "[parameters('allowedTagValues')]",
                }
            ]
        },
        "then": {
            "effect": "addToNetworkGroup",
            "details": {
                "networkGroupId": "${azurerm_network_manager_network_group.network_group.id}"
            }
        }
    })

    parameters = jsonencode({
        "allowedTagValues": {
            "type": "Array",
            "metadata": {
                "description": "The list of allowed tag values"
            }
        }
    })


}

resource "azurerm_management_group_policy_assignment" "network_group_policy_assignment" {
  name                 = "example-assignment"
  management_group_id          = var.management_group_id
  policy_definition_id = azurerm_policy_definition.network_group_policy.id

  parameters = jsonencode({
    "allowedTagValues": {
        "value": var.tagValues
    }
  })
}