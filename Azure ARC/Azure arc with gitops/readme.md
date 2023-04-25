# Sure, here is a step-by-step guide to deploying and running Kubernetes Apps in Azure and on-premises with GitOps using AKS hybrid and Azure Arc.

## Step 1: Prerequisites

Before you begin, you will need to have the following:

An Azure subscription
The Azure CLI installed on your machine
A Git repository to store your Kubernetes manifests
A Docker image for your application
Terraform installed on your machine

## Step 2: Create a Terraform file

In this step, you will create a Terraform file that defines the infrastructure you need for your deployment.

The Terraform file should include the following resources:

An Azure Resource Group to hold all the resources.
An AKS cluster.
An on-premises Kubernetes cluster connected to Azure Arc.
A Log Analytics Workspace to collect logs from both clusters.
The GitOps Operator Helm chart installed in both clusters.
The Terraform code can be found in the previous answer.

## Step 3: Authenticate to Azure

To authenticate to Azure, open the command prompt and run the following command:

```az login```

This command will open a browser window where you can sign in to Azure with your credentials.


## Step 4: Initialize and Apply Terraform Configuration

In this step, you will initialize Terraform in the directory where you have saved the Terraform file:

```terraform init```
Once Terraform is initialized, you can apply the configuration:

```terraform apply```

This command will prompt you to confirm the changes that Terraform will make to your Azure subscription. Type "yes" to confirm.

## Step 5: Configure GitOps

In this step, you will configure GitOps for your deployment. GitOps is a methodology that uses Git as the single source of truth for declarative infrastructure and applications.

To configure GitOps, you need to:

Create a Git repository to store your Kubernetes manifests.
Add the GitOps operator to the Git repository.
Commit the Kubernetes manifests to the Git repository.
Once you have done this, the GitOps operator will automatically deploy your Kubernetes manifests to your AKS cluster and your on-premises cluster connected to Azure Arc.

## Step 6: Deploy Your Application

In this step, you will deploy your application to the AKS cluster using GitOps.

To deploy your application, you need to:

Create a Kubernetes manifest for your application.
Add the Kubernetes manifest to the Git repository.
Commit the Kubernetes manifest to the Git repository.
Once you have done this, the GitOps operator will automatically deploy your application to the AKS cluster.

## Step 7: Verify Your Deployment

To verify your deployment, you can use the Kubernetes command-line interface (kubectl).

To get the IP address of your application, run the following command:

```kubectl get service my-app -o wide```

This command will display the IP address of your application.

To test your application, open a web browser and enter the IP address in the address bar.

Step 8: Conclusion

In this guide, you learned how to deploy and run Kubernetes Apps in Azure and on-premises with GitOps using AKS hybrid and Azure Arc. By following these steps, you can deploy your applications with confidence and ensure that they are always up-to-date and secure.