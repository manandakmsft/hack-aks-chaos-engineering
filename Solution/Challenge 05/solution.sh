CLUSTER_NAME="<cluster-name>"
RESOURCE_GROUP="<rg>"
AZURE_MONITOR_NAME="<azure-monitor-name>"
GRAFANA_NAME="<grafana-name>"
LOCATION="<location>"

# Create Azure Monitor resource
az resource create \
    --resource-group $RESOURCE_GROUP \
    --namespace microsoft.monitor \
    --resource-type accounts \
    --name $AZURE_MONITOR_NAME \
    --location eastus \
    --properties '{}'

# Create Grafana instance
az grafana create \
    --name $GRAFANA_NAME \
    --resource-group $RESOURCE_GROUP 


# Place the Azure Managed Grafana and Azure Monitor resource IDs in variables
grafanaId=$(az grafana show \
                --name $GRAFANA_NAME \
                --resource-group $RESOURCE_GROUP \
                --query id \
                --output tsv)
azuremonitorId=$(az resource show \
                    --resource-group $RESOURCE_GROUP \
                    --name $AZURE_MONITOR_NAME \
                    --resource-type "Microsoft.Monitor/accounts" \
                    --query id \
                    --output tsv)

# Link Azure Monitor and Azure Managed Grafana to the AKS cluster
az aks update \
    --name $CLUSTER_NAME \
    --resource-group $RESOURCE_GROUP \
    --enable-azure-monitor-metrics \
    --azure-monitor-workspace-resource-id $azuremonitorId \
    --grafana-resource-id $grafanaId
