param appServiceAPIAppName string 
param location string = resourceGroup().location
param containerRegistryName string
param appServicePlanId string
param appSettings array = []

@secure()
param containerRegistryServerUsername string
@secure()
param containerRegistryServerPassword string
param containerRegistryImageTag string
param containerRegistryImageName string 

var dockerAppSettings = [
  {name:'DOCKER_REGISTRY_SERVER_URL', value: 'https://${containerRegistryName}.azurecr.io'}
  { name: 'DOCKER_REGISTRY_SERVER_USERNAME', value: containerRegistryServerUsername }
  { name: 'DOCKER_REGISTRY_SERVER_PASSWORD', value: containerRegistryServerPassword }
]


var mergeAppSettings = concat(appSettings,  dockerAppSettings)

resource appServiceAPIApp 'Microsoft.Web/sites@2022-03-01' = {
  name: appServiceAPIAppName
  location: location
  kind: 'app'
  // identity: {
  //   type: 'SystemAssigned'
  // }
  properties: {
    serverFarmId: appServicePlanId
    httpsOnly: true
    siteConfig: {
      ftpsState: 'FtpsOnly'
      linuxFxVersion: 'DOCKER|${containerRegistryName}.azurecr.io/${containerRegistryImageName}:${containerRegistryImageTag}'
      appSettings: mergeAppSettings
      appCommandLine: ''
    }
  }
}




output appServiceAppAPIHostName string = appServiceAPIApp.properties.defaultHostName       //do we need this same outpt from both FE & BE
output systemAssignedIdentityPrincipalId string = appServiceAPIApp.identity.principalId 
