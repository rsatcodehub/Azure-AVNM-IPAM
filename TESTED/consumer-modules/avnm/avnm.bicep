@description('Location of azure virtual network manager')
param location string

@description('Name of Azure virtual network manager')
param name string

@description('Management groups to be managed by AVNM')
param managementGroups array = []

module testWithMg 'br/BicepModules:network/network-manager:1.0.1' = {
  name: 'test-avnm-with-mg'
  params: {
    name: name
    location: location
    managementGroups: managementGroups
    resourceLock: 'CanNotDelete'
    // tags: {
    //   environment: 'test'
    // }
  }
}
