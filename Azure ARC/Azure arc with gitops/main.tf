# Configure Azure provider
provider "azurerm" {
  features {}
}

# Define resource group and location
resource "azurerm_resource_group" "rg" {
  name     = "my-rg"
  location = "westus2"
}

# Define AKS cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "my-aks-cluster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  dns_prefix = "myakscluster"

  linux_profile {
    admin_username = "azureuser"
  }

  node_resource_group = "my-aks-node-rg"

  service_principal {
    client_id     = "CLIENT_ID"
    client_secret = "CLIENT_SECRET"
  }

  tags = {
    Environment = "Dev"
  }
}

# Connect on-premises cluster to Azure Arc
resource "azurerm_kubernetes_cluster" "arc" {
  name                = "my-on-premises-cluster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  dns_prefix = "myonpremcluster"

  linux_profile {
    admin_username = "azureuser"
  }

  tags = {
    Environment = "Dev"
  }
}

resource "azurerm_log_analytics_workspace" "logs" {
  name                = "my-logs"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Install GitOps operator in AKS
resource "helm_release" "gitops_operator" {
  name       = "flux"
  repository = "https://charts.fluxcd.io"

  chart   = "flux"
  version = "1.3.0"

  namespace = "flux-system"

  set {
    name  = "git.url"
    value = "GIT_REPO_URL"
  }

  set {
    name  = "git.readonly"
    value = "true"
  }

  set {
    name  = "git.path"
    value = "clusters/${azurerm_kubernetes_cluster.aks.name}"
  }

  depends_on = [
    azurerm_kubernetes_cluster.aks,
    azurerm_log_analytics_workspace.logs
  ]
}

# Install GitOps operator in on-premises cluster connected to Azure Arc
resource "helm_release" "gitops_operator_arc" {
  name       = "flux"
  repository = "https://charts.fluxcd.io"

  chart   = "flux"
  version = "1.3.0"

  namespace = "flux-system"

  set {
    name  = "git.url"
    value = "GIT_REPO_URL"
  }

  set {
    name  = "git.readonly"
    value = "true"
  }

  set {
    name  = "git.path"
    value = "clusters/${azurerm_kubernetes_cluster.arc.name}"
  }

  set {
    name  = "git.pollInterval"
    value = "5m"
  }

  depends_on = [
    azurerm_kubernetes_cluster.arc,
    azurerm_log_analytics_workspace.logs
  ]
}

# Define Kubernetes namespace and deployment
resource "kubernetes_namespace" "namespace" {
  metadata {
    name = "my-app-namespace"
  }
}

# resource "kubernetes_deployment" "deployment" {
#   metadata {
#     name      = "deployment"
#     namespace = kubernetes_namespace.namespace.metadata[0].name
# }

# spec {
# selector {
# match_labels = {
# app = "my-app"
# }
# }
# replicas = 3

# template {
#   metadata {
#     labels = {
#       app = "my-app"
#     }
#   }

#   spec {
#     container {
#       name  = "my-container"
#       image = "my-docker-image:latest"
#       ports {
#         container_port = 80
#       }
#     }
#   }
# }
# }
# }
