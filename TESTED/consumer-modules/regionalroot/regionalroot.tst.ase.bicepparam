using './regionalroot.bicep'

param regionLocation = 'australiasoutheast'
param regionShortName = 'ase'
param poolNumber = '001'
param rootAddressPrefix = '10.100.0.0/16'
param avnmName = 'vnm-tst-ae-ipam-001'
//param resourceLock = 'CanNotDelete'
param childPools = [
  {
    prefix: 'dev'
    displayName: 'Development'
    addressPrefix: '10.100.0.0/19'
  }
]
