locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  tags = merge(var.tags, local.module_tag)

  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE        = "true"
    WEBSITE_ENABLE_SYNC_UPDATE_SITE            = "true"
    JAVA_OPTS                                  = var.application_type == "java" ? "-Dlog4j2.formatMsgNoLookups=true" : null
    LOG4J_FORMAT_MSG_NO_LOOKUPS                = var.application_type == "java" ? "true" : null
    WEBSITE_USE_PLACEHOLDER                    = "0"
    AZURE_LOG_LEVEL                            = "debug"
    APPINSIGHTS_INSTRUMENTATIONKEY             = var.enable_appinsights ? azurerm_application_insights.this[0].instrumentation_key : null
    ApplicationInsightsAgent_EXTENSION_VERSION = var.enable_appinsights && var.application_type == "java" ? "~3" : null
  }

}

