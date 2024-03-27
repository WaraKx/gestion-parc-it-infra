# Configuration du provider Azure
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 3.0.0"
    }
  }
  required_version = ">= 0.14.9"
}
provider "azurerm" {
  features {}
}

# Déclaration du groupe de ressources Azure
resource "azurerm_resource_group" "example" {
  name     = "rg-votre_nom-{remplacez_par_votre_nom}-${random_integer.example.result}"
  location = "West Europe"
}

# Déclaration du plan App Service
resource "azurerm_app_service_plan" "example" {
  name                = "asp-votre_nom-{remplacez_par_votre_nom}-${random_integer.example.result}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  kind                = "Linux"
  sku {
    tier = "Basic"
    size = "B1"
  }
}

# Déclaration de l'application web
resource "azurerm_app_service" "example" {
  name                = "webapp-votre_nom-{remplacez_par_votre_nom}-${random_integer.example.result}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id

  site_config {
    java_version     = "1.7"
    java_container   = "JAVA"
    java_container_version = "17"
  }
}
