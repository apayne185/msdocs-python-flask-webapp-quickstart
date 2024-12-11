param location string
param appServicePlanName string 
param appServiceAPIName string
param containerRegistryName string
param containerRegistryImageTag string 
param containerRegistryImageName string
param keyVaultName string 



module keyVault 'modules/key-vault.bicep' = {
  name: keyVaultName
  params: {
    location: location
    keyVaultName: keyVaultName
    // roleAssignments: keyVaultRoleAssignments
    }
}



module appServicePlan 'modules/app-service-plan.bicep' = {
  name: appServicePlanName
  params: {
    appServicePlanName: appServicePlanName
    location: location
  }
}



module containerRegistry 'modules/container-registry.bicep' = {
  name: containerRegistryName
  params: {
    containerRegistryName: containerRegistryName
    location: location
  }
}



module appServiceAPI 'modules/be-app-service.bicep' = {
  name: appServiceAPIName
  params: {
    appServiceAPIAppName: appServiceAPIName
    location: location
    containerRegistryName: containerRegistryName
    // containerRegistryServerUsername: containerRegistry.outputs.registryUsername
    // containerRegistryServerPassword: containerRegistry.outputs.registryPassword
    containerRegistryImageName: containerRegistryImageName
    containerRegistryImageTag: containerRegistryImageTag
    appServicePlanId: appServicePlan.outputs.planId
    appSettings: [
      { name: 'DOCKER_REGISTRY_SERVER_URL', value: 'https://${containerRegistry.outputs.registryLoginServer}' }
      { name: 'DOCKER_REGISTRY_SERVER_USERNAME', value: containerRegistry.outputs.registryUsername }
      { name: 'DOCKER_REGISTRY_SERVER_PASSWORD', value: containerRegistry.outputs.registryPassword }
    ]
    }
}
