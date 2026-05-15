using './regionalroot.bicep'

param regionLocation = 'australiaeast'
param regionShortName = 'ae'
param poolNumber = '001'
param rootAddressPrefix = '10.101.0.0/16'
param avnmName = 'vnm-tst-ae-ipam-001'
//param resourceLock = 'CanNotDelete'
param childPools = [
  {
    prefix: 'dev'
    displayName: 'Development'
    addressPrefix: '10.101.0.0/19'
  }
]
