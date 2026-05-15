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

module testregionalPool 'br/BicepModules:network/ipam-regionalpool:1.0.1' = {
  name: 'deploy-regional-pool-${regionLocation}'
  params: {
    avnmName: avnmName
    regionLocation: regionLocation
    regionShortName: regionShortName
    poolNumber: poolNumber
    rootAddressPrefix: rootAddressPrefix
    resourceLock: resourceLock

    childPools: childPools
  }
}
