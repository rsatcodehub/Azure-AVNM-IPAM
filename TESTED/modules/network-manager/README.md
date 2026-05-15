# Azure Virtual Network Manager

Deploys an Azure Virtual Network Manager (IPAM) instance with configurable scope and scope accesses.

## Details

{{Add detailed information about the module}}

## Prerequisites

The `Microsoft.Network` resource provider must be registered at both the subscription and management group scope before deploying this module.

```bash
# Check current registration state on the target subscription
az provider show --namespace Microsoft.Network --query "registrationState" -o tsv

# Register at subscription scope
az provider register --namespace Microsoft.Network --subscription <subscriptionId>

# Register at management group scope
az provider register --namespace Microsoft.Network --management-group-id <managementGroupId>
```

## Parameters

| Name               | Type     | Required | Description                                  |
| :----------------- | :------: | :------: | :------------------------------------------- |
| `name`             | `string` | Yes      | Name of the Azure Virtual Network Manager    |
| `location`         | `string` | Yes      | Location for AVNM deployment                 |
| `managementGroups` | `array`  | No       | Management groups to be managed by AVNM      |
| `resourceLock`     | `string` | No       | Optional. Specify the type of resource lock. |
| `tags`             | `object` | No       | Optional. Resource tags.                     |

## Outputs

| Name     | Type     | Description                                                    |
| :------- | :------: | :------------------------------------------------------------- |
| `avnmId` | `string` | The resource ID of the deployed Azure Virtual Network Manager. |
| `name`   | `string` | The name of the deployed Azure Virtual Network Manager.        |

## Example Usage

```bicep

module testWithMg '../main.bicep' = {
  name: 'test-avnm-with-mg'
  params: {
    name: 'avnm-test-mg'
    location: 'australiaeast'
    managementGroups: [
      '/providers/Microsoft.Management/managementGroups/az-swinburneuniversityoftechnology-test-mg'
    ]
    resourceLock: 'CanNotDelete'
    tags: {
      environment: 'test'
    }
  }
}

```
