Param(
    [parameter(Mandatory=$false)]
    [string]$resourceGroupName="aibootcamp",
    [parameter(Mandatory=$false)]
    [string]$clusterName="gpuCluster"
)

# Browse AKS dashboard
Write-Host "Browse AKS cluster $clusterName" -ForegroundColor Yellow
az aks browse `
--resource-group=$resourceGroupName `
--name=$clusterName