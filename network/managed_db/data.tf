module "naming_conv"{
  source = "../../foundation/naming_conv"
  #source = "git::https://github.com/nara-alz-org/modules.git//azure/foundation/naming_conv"
  app_key = var.app_key
  environment = var.environment
  line_of_business_key = var.line_of_business_key
  org_email_domain = var.org_email_domain
  org_key = var.org_key
  location = var.location
  team_key = var.team_key
  db_type = ""
}