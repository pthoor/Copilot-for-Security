targetScope = 'resourceGroup'

@minLength(3)
@maxLength(63)
param capacityName string

var uniqueStringNoHyphens = replace(uniqueString(resourceGroup().id), '-', '')
var uniqueCapacityName = '${toLower(capacityName)}${uniqueStringNoHyphens}'

@allowed([
    'EU'
    'ANZ'
    'US'
    'UK'
])
param geo string

var locationMap = {
  EU: 'westeurope'
  ANZ: 'australiaeast'
  US: 'eastus'
  UK: 'uksouth'
}

var location = contains(locationMap, geo) ? locationMap[geo] : 'defaultlocation'

param numberOfUnits int

@allowed([
    'NotAllowed'
    'Allowed'
])
param crossGeoCompute string

resource Copilot 'Microsoft.SecurityCopilot/capacities@2023-12-01-preview' = {
    name: uniqueCapacityName
    location: location
    properties: {
        numberOfUnits: numberOfUnits
        crossGeoCompute: crossGeoCompute
        geo: geo
    }
}
