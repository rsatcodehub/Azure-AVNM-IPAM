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
