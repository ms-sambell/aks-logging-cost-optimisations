param dcrName string = 'dcr-demo'
param lawResourceId string

param tags object = {}
param location string = resourceGroup().location


param lawTable string 

param transformKql string 

var stream = 'Microsoft-Table-${lawTable}'
var destination = 'law'


resource dcr 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: dcrName
  location: location
  tags: tags
  kind: 'WorkspaceTransforms'
  properties: {
    dataSources: {}
    destinations: {
      logAnalytics: [
        {
          workspaceResourceId: lawResourceId
          name: destination
        }
      ]
    }
    dataFlows: [
      {
        streams: [
          stream
        ]
        destinations: [
          destination
        ]
        transformKql: transformKql
      }
    ]
  }
}


resource lawUpdate 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: '${split(lawResourceId, '/')[8]}' 
  location: location
  properties: {
    defaultDataCollectionRuleResourceId: dcr.id
  }
}
