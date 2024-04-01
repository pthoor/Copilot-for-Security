# Microsoft Copilot for Security

This repository contains an Azure Bicep file for deploying a `Microsoft.SecurityCopilot/capacities` resource, along with GitHub Actions workflows for automated deployment and destruction of resources.

## Azure Bicep

The `main.bicep` file in this repository deploys a `Microsoft.SecurityCopilot/capacities` resource with the following properties:

- `capacityName`: The name of the capacity.
- `geo`: The geographical location code. This can be one of the following: 'EU', 'ANZ', 'US', 'UK'.
- `location`: The Azure location is automatically filled in and determined when you choose `geo` (geographical location), see bicep code for logic.
- `numberOfUnits`: The number of units.
- `crossGeoCompute`: Whether cross-geo compute is allowed. This can be either 'Allowed' or 'NotAllowed'.

The `main.bicepparam` file contains the parameter values for the `main.bicep` file. You can update the parameter values in this file as necessary.

## GitHub Actions

There are two GitHub Actions workflows in this repository:

1. **Deployment Workflow (`deploy.yml`)**: This workflow deploys the Bicep file to Azure. It runs at 8 AM UTC from Monday to Friday.

2. **Destruction Workflow (`destroy.yml`)**: This workflow destroys the deployed resources by deleting the resource group in Azure. It runs at 5 PM UTC from Monday to Friday.

## Usage

To use this repository, you need to do the following:

1. Fork this repository to your own GitHub account.
2. Set up your Azure credentials as a secret in your GitHub repository. You can do this in the repository settings under the "Secrets and variables" section.
  - Run the following command in Cloud Shell or another PowerShell window with right permissions to create a Service Principal with **Contributor** rights.
  `az ad sp create-for-rbac --name {app-name} --role contributor --scopes /subscriptions/{subscription-id}/resourceGroups/exampleRG --json-auth` 
  - Copy the output and then paste it in the **Value** section when you are creating the new secret in GitHub Actions.
3. Update the parameters in the `main.bicepparam` file and the GitHub Actions workflows as necessary.

Please note that deleting a resource group will delete all resources within that group. Make sure this is what you want before running the destruction workflow.

## Contributing

Contributions are welcome! Please feel free to submit a pull request.

## License

This project is licensed under the terms of the MIT license.
