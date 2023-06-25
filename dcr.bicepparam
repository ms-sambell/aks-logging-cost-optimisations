using 'modules/dcr.bicep'

param dcrName = 'containerLogs-dcr'
param lawResourceId = ''
param lawTable = 'ContainerLogV2'
param transformKql = 'source\n| where LogMessage !has "health"\n| where LogMessage !has "kube-probe"\n\n'
