param location string = resourceGroup().location
param keyVaultName string = 'anna-kv'


resource keyVault 'Microsoft.KeyVault/vaults@2022-07-01' = {
  name: keyVaultName
  location: location
  properties: {
    enabledForDeployment: true
    enableRbacAuthorization: true
    enableSoftDelete: true
    enabledForTemplateDeployment: true
        sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: subscription().tenantId
    accessPolicies: []
  }
}
