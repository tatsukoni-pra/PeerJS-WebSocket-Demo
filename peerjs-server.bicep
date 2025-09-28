// パラメータ定義
@description('The name prefix for all resources')
param namespace string = 'peerjs-server-demo'

@description('The location for all resources')
param location string = resourceGroup().location

@description('Resource tags')
param tags object = {
  Name: 'peerjs-server-demo'
  Environment: 'demo'
}

/* -------- リソース -------- */
// App Service Plan
resource appServicePlan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: namespace
  location: location
  tags: tags
  sku: {
    name: 'B1'
  }
  kind: 'linux'
  properties: {
    reserved: true
  }
}

// App Service
var configAppsettingsProperties = {
  SCM_DO_BUILD_DURING_DEPLOYMENT: 'false'
  WEBSITE_TIME_ZONE: 'Asia/Tokyo'
  DOCKER_REGISTRY_SERVER_URL: 'https://index.docker.io'
  WEBSITES_ENABLE_APP_SERVICE_STORAGE: 'false'
  WEBSITES_PORT: '9000'
}

var configWebProperties = {
  alwaysOn: true
  appCommandLine: 'peerjs --port 9000 --path /peerjs --concurrent_limit 10000 --allow_discovery true'
  healthCheckPath: '/peerjs'
  linuxFxVersion: 'DOCKER|peerjs/peerjs-server:0.6.1'
  webSocketsEnabled: true
}

resource appService 'Microsoft.Web/sites@2022-09-01' = {
  name: namespace
  location: location
  tags: tags
  kind: 'app,linux,container'
  properties: {
    reserved: true
    httpsOnly: true
    publicNetworkAccess: 'Enabled'
    serverFarmId: appServicePlan.id
    clientAffinityEnabled: false
  }
}

resource appServiceConfigAppsettings 'Microsoft.Web/sites/config@2022-09-01' = {
  parent: appService
  name: 'appsettings'
  properties: configAppsettingsProperties
}

resource appServiceConfigWeb 'Microsoft.Web/sites/config@2022-09-01' = {
  parent: appService
  name: 'web'
  properties: configWebProperties
}
