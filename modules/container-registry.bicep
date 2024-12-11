param location string = resourceGroup().location
param containerRegistryName string



resource containerRegistry 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: containerRegistryName
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: true
  }
}

output registryLoginServer string = containerRegistry.properties.loginServer
output registryUsername string = listKeys(containerRegistry.id, '2023-07-01').username
output registryPassword string = listKeys(containerRegistry.id, '2023-07-01').passwords[0].value
