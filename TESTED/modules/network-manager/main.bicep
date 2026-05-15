metadata name = 'Azure Virtual Network Manager'
metadata description = 'Deploys an Azure Virtual Network Manager (IPAM) instance with configurable scope and scope accesses.'
metadata owner = 'Swinburne'

@description('Name of the Azure Virtual Network Manager')
param name string

@description('Location for AVNM deployment')
param location string

@description('Management groups to be managed by AVNM')
@metadata({
  example: '/providers/Microsoft.Management/managementGroups/mg-name'
})
param managementGroups array = []

@description('Optional. Specify the type of resource lock.')
@allowed([
  'NotSpecified'
  'ReadOnly'
  'CanNotDelete'
])
param resourceLock string = 'CanNotDelete'

@description('Optional. Resource tags.')
@metadata({
  doc: 'https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/tag-resources?tabs=bicep#arm-templates'
  example: {
    tagKey: 'string'
  }
})
param tags object = {}

var lockName = toLower('${name}-${resourceLock}-lck')
var hasManagementGroups = length(managementGroups) > 0

resource avnm 'Microsoft.Network/networkManagers@2024-07-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    networkManagerScopes: {
      managementGroups: hasManagementGroups ? managementGroups : []
      subscriptions: []
    }
    networkManagerScopeAccesses: []
  }
}

resource lock 'Microsoft.Authorization/locks@2017-04-01' = if (resourceLock != 'NotSpecified') {
  scope: avnm
  name: lockName
  properties: {
    level: resourceLock
    notes: (resourceLock == 'CanNotDelete')
      ? 'Cannot delete resource or child resources.'
      : 'Cannot modify the resource or child resources.'
  }
}

@description('The resource ID of the deployed Azure Virtual Network Manager.')
output avnmId string = avnm.id

@description('The name of the deployed Azure Virtual Network Manager.')
output name string = avnm.name
