provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "adfRG" {
  name     = "adfRG"
  location = "West Europe"
}

resource "azurerm_data_factory" "adf" {
  name                = "adityaadf1"
  location            = azurerm_resource_group.adfRG.location
  resource_group_name = azurerm_resource_group.adfRG.name
}

resource "azurerm_storage_account" "Sourceadfstorage" {
  name                     = "adityasourcecodestorage"
  resource_group_name      = azurerm_resource_group.adfRG.name
  location                 = azurerm_resource_group.adfRG.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_account" "Targetadfstorage" {
  name                     = "adityatargetcodestorage"
  resource_group_name      = azurerm_resource_group.adfRG.name
  location                 = azurerm_resource_group.adfRG.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "sourceadfcontainer" {
  name                  = "sourceadfcontainer"
  storage_account_name  = azurerm_storage_account.Sourceadfstorage.name
}

resource "azurerm_storage_container" "targetadfcontainer" {
  name                  = "targetadfcontainer"
  storage_account_name  = azurerm_storage_account.Targetadfstorage.name
}

