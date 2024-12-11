param appServicePlanName string 
param location string = resourceGroup().location



resource appServicePlan 'Microsoft.Web/serverfarms@2021-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'B1'
    tier: 'Basic'
    size: 'B1'
    family: 'B'
    capacity: 1
  }
  kind: 'linux'
  properties: {
    reserved: true     // for a linux-based AS
  }
}


output planId string = appServicePlan.id
