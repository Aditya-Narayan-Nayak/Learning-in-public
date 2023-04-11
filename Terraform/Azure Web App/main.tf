provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = var.appservicename
}

resource "azurerm_app_service_plan" "appplan" {
    location = azurerm_resource_group.rg.location
    name     = "adityanarayan786-appserviceplan"  
    resource_group_name = azurerm_resource_group.rg.name
    sku {
      size = "S1"
      tier = "Standard"
    }
}

resource "azurerm_app_service" "appservice" {
    app_service_plan_id = azurerm_app_service_plan.appplan.id
    location            = azurerm_resource_group.rg.location
    name                = "adityanarayan786-appservice"
    resource_group_name = azurerm_resource_group.rg.name

    site_config {
        dotnet_framework_version = "v4.0"
        remote_debugging_enabled = true
        remote_debugging_version = "VS2019"
    }   
}