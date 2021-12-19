# Guides for Using AKS-Provision

## Prerequisites

### Terraform CLI

To use `AKS-Provision`, you need to install `Terraform CLI` locally and the version should be 0.12.20 or above.
Visit Terraform official [download page](https://www.terraform.io/downloads.html) to download this. After installing, try to run the command `terraform -v`, if things go well, you should see something like this:

```bash
$ terraform -v

Terraform v0.12.18
```

### Authentication

#### Option 1: Az login

* Install `Azure CLI`. [Download here](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest).

* Login using your Azure username and password.

  ```bash
  az login 
  ```

* Select your subscription

  ```bash
  az account set -s <subscription_name>
  ```

#### Option 2: Service Principle for Terraform

* Export the below environment variables

    ```
    # Azure Service Principle
    ARM_SUBSCRIPTION_ID='Your_SP_Subscription_Id'
    ARM_TENANT_ID='Your_SP_Tenant_Id'
    ARM_CLIENT_ID='Your_SP_Client_Id'
    ARM_CLIENT_SECRET='Your_SP_Client_Secret'
    ```

## How to use

### Prerequisite

1.Log Analytics Workspace

A Log Analytics workspace is a unique environment for Azure Monitor log data. According to

### Usage
* In the project root folder, run the following command to **init** terraform project.

    ```bash
    terraform init
    ```

#### Basic Usage
All things you need do is to change the value in config file  `template.tfvars` according to your requirement.

* After completing all necessary fields, run commands below to review the changes.

    ```bash
    terraform plan -var-file="template.tfvars"
    ```

* After completed creating AKS on Azure, you can access the dashboard using the following steps:

    1. If you do not already have kubectl installed in your CLI, run the following command:
        ```bash
        az aks install-cli
        ```
    2. Get the credentials for your cluster by running the following command:
        ```bash
        az aks get-credentials --resource-group <resource_group> --name <aks_name>
        ```
    3. Open the Kubernetes dashboard by running the following command:
        ```bash
        az aks browse --resource-group <resource_group> --name <aks_name>
        ```