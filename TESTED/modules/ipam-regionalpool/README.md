# IPAM Regional Root Pool

Deploys IPAM Regional Root Pool and Child Pools. Pre-requisite is an existing Azure Virtual Network Manager instance.

## Details

Deploys IPAM regional root pool and child pools for each region.

Refer to the documentation for more details `https://swincloud.atlassian.net/wiki/spaces/CPH/pages/1382481949/Azure+IP+address+management+IPAM+Design`

## Parameters

| Name                | Type     | Required | Description                                                                             |
| :------------------ | :------: | :------: | :-------------------------------------------------------------------------------------- |
| `regionLocation`    | `string` | Yes      | Required. Region location e.g. australiaeast.                                           |
| `regionShortName`   | `string` | Yes      | Required. Region short name e.g. ae.                                                    |
| `poolNumber`        | `string` | Yes      | Required. Regional root pool number e.g. 001.                                           |
| `rootAddressPrefix` | `string` | Yes      | Required. Regional root pool address prefix e.g. 10.x.x.x/16.                           |
| `childPools`        | `array`  | Yes      | Required. Array of child pool objects containing prefix, displayName and addressPrefix. |
| `avnmName`          | `string` | Yes      | Required. Azure Virtual Network Manager name e.g. vnm-tst-xxxx.                         |
| `resourceLock`      | `string` | No       | Optional. Specify the type of resource lock.                                            |

## Outputs

| Name           | Type     | Description                                         |
| :------------- | :------: | :-------------------------------------------------- |
| `rootPoolName` | `string` | The name of the deployed regional root pool.        |
| `rootPoolId`   | `string` | The resource ID of the deployed regional root pool. |

## Examples

```bicep

module testregionalPool '../main.bicep' = {
  name: 'deploy-regional-pool'
  params: {
    avnmName: 'vnm-tst-ae-ipam-001'
    regionLocation: 'australiasoutheast'
    regionShortName: 'ase'
    poolNumber: '001'
    rootAddressPrefix: '10.100.0.0/16'
    resourceLock: 'CanNotDelete'

    childPools: [
      {
        prefix: 'dev'
        displayName: 'Development'
        addressPrefix: '10.100.0.0/19'
      }
      {
        prefix: 'tst'
        displayName: 'Test'
        addressPrefix: '10.100.32.0/19'
      }
    ]
  }
}

```