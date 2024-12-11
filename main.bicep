param location string
param appServicePlanName string 
param appServiceAPIName string
param containerRegistryName string
param containerRegistryImageTag string 
param containerRegistryImageName string








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
    containerRegistryServerUsername: containerRegistry.outputs.adminUsername
    containerRegistryServerPassword: containerRegistry.outputs.adminPassword
    containerRegistryImageName: containerRegistryImageName
    containerRegistryImageTag: containerRegistryImageTag
    appServicePlanId: appServicePlan.outputs.planId
    }
}
