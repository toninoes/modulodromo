# GitHub Actions access to Azure Module

This module allows your GitHub Actions workflows to access resources in Azure, without needing to store the Azure credentials 
as long-lived GitHub secrets.

GitHub's OIDC provider works with Azure's workload identity federation. For an overview, see Microsoft's documentation at 
[Workload identity federation](https://docs.microsoft.com/en-us/azure/active-directory/develop/workload-identity-federation).

To configure the OIDC identity provider in Azure, you will need to perform the following configuration. For instructions 
on making these changes, refer to the [Azure documentation](https://docs.microsoft.com/en-us/azure/developer/github/connect-from-azure).

Overview of GitHub using Open ID Connect to authenticate to Azure:
![diagram](img/oidc.png)

This module performs:
- Create an Entra ID application and a service principal.
- Add federated credentials for the Entra ID application.
- Also creates 3 environment secrets in your repo for AZURE_CLIENT_ID, AZURE_TENANT_ID, and AZURE_SUBSCRIPTION_ID. 

## Usage

```hcl
module "gha_access_azure" {
  source = "git::git@github.com:toninoes/modulodromo.git//azure/github_actions_access_to_azure"

  app_display_name     = "my-app-name"
  github_environment   = "sandbox"
  github_repository    = "my-repository"
  resource_group_name  = "mi-resource-group-for-gha-access-to-azure"
  role_definition_name = "Contributor"
}
```

Testing OIDC. Create a workflow under .github/workflows directory of your repo:
```yml
name: Run Azure CLI Login with OpenID Connect
on: [push, workflow_dispatch]

permissions:
  id-token: write # Require write permission to Fetch an OIDC token.

jobs:
  test:
    runs-on: ubuntu-latest
    environment: sandbox
    steps:
    - name: Azure CLI Login
      uses: azure/login@v2
      with:
        client-id: ${{ secrets.AZURE_CLIENT_ID }}
        tenant-id: ${{ secrets.AZURE_TENANT_ID }}
        subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}

    - name: Azure CLI script
      uses: azure/cli@v2
      with:
        azcliversion: latest
        inlineScript: |
          az account show
          # You can write your Azure CLI inline scripts here.
```
