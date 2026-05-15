metadata name = 'IPAM Regional Root Pool'
metadata description = 'Deploys IPAM Regional Root Pool and Child Pools. Pre-requisite is an existing Azure Virtual Network Manager instance.'
metadata owner = 'Swinburne'

@description('Required. Region location e.g. australiaeast.')
param regionLocation string

@description('Required. Region short name e.g. ae.')
param regionShortName string

@description('Required. Regional root pool number e.g. 001.')
param poolNumber string

@description('Required. Regional root pool address prefix e.g. 10.x.x.x/16.')
param rootAddressPrefix string

@description('Required. Array of child pool objects containing prefix, displayName and addressPrefix.')
param childPools array

@description('Required. Azure Virtual Network Manager name e.g. vnm-tst-xxxx.')
param avnmName string

@description('Optional. Specify the type of resource lock.')
@allowed([
  'NotSpecified'
  'ReadOnly'
  'CanNotDelete'
])
param resourceLock string = 'CanNotDelete'

var lockName = toLower('${regionShortName}-pool-${poolNumber}-${resourceLock}-lck')

resource rootPool 'Microsoft.Network/networkManagers/ipamPools@2024-07-01' = {
  name: '${avnmName}/${regionShortName}-pool-${poolNumber}'
  location: regionLocation
  properties: {
    displayName: '${regionLocation}-Pool${poolNumber} (${regionShortName}-pool-${poolNumber})'
    addressPrefixes: [
      rootAddressPrefix
    ]
  }
}

@batchSize(1)
resource childPool 'Microsoft.Network/networkManagers/ipamPools@2024-07-01' = [
  for pool in childPools: {
    name: '${avnmName}/${pool.prefix}-${regionShortName}-pool-${poolNumber}'
    location: regionLocation
    properties: {
      displayName: '${pool.displayName} (${pool.prefix}-${regionShortName}-pool-${poolNumber})'
      parentPoolName: '${regionShortName}-pool-${poolNumber}'
      addressPrefixes: [
        pool.addressPrefix
      ]
    }
    dependsOn: [rootPool]
  }
]

resource lock 'Microsoft.Authorization/locks@2020-05-01' = if (resourceLock != 'NotSpecified') {
  scope: rootPool
  name: lockName
  properties: {
    level: resourceLock
    notes: (resourceLock == 'CanNotDelete')
      ? 'Cannot delete resource or child resources.'
      : 'Cannot modify the resource or child resources.'
  }
}

@description('The name of the deployed regional root pool.')
output rootPoolName string = last(split(rootPool.name, '/'))

@description('The resource ID of the deployed regional root pool.')
output rootPoolId string = rootPool.id
