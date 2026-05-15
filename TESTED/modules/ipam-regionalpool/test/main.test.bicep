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
