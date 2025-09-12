CLUSTER_NAME="<cluster-name>"
RESOURCE_GROUP="<rg>"
AMW_NAME="<workspace-name>"
GRAFANA_NAME="<grafana-name"
LOCATION="<location>"

# Get your Entra ID (AAD) user object ID
# This may fail if ran in the portal
ME_OBJECT_ID="$(az ad signed-in-user show --query id -o tsv)"


#create Azure monitor account
az monitor account create \
  --resource-group "$RESOURCE_GROUP" \
  --name "$AMW_NAME" \
  --location "$LOCATION"

#store the AMW id for Prometheus destination 
AMW_ID="$(az monitor account show \
  --resource-group "$RESOURCE_GROUP" \
  --name "$AMW_NAME" \
  --query id -o tsv)"


#install grafana and get ID for read permissions for AMW
#may need to install extension
az grafana create \
  --resource-group "$RESOURCE_GROUP" \
  --name "$GRAFANA_NAME" \
  --sku-tier Standard

GRAFANA_ID="$(az grafana show \
  --resource-group "$RESOURCE_GROUP" \
  --name "$GRAFANA_NAME" \
  --query id -o tsv)"

GRAFANA_MI="$(az grafana show \
  --resource-group "$RESOURCE_GROUP" \
  --name "$GRAFANA_NAME" \
  --query identity.principalId -o tsv)"

echo 'Granting reader permissions to Azure monitor workspace...'
  az role assignment create \
  --assignee-object-id "$GRAFANA_MI" \
  --assignee-principal-type ServicePrincipal \
  --role "Monitoring Reader" \
  --scope "$AMW_ID"
echo 'Monitoring Reader added to workspace.' 
  
echo 'Adding Grafana viewer role to current user...'
# Grant Grafana Viewer on the Grafana resource
az role assignment create \
  --assignee-object-id "$ME_OBJECT_ID" \
  --assignee-principal-type User \
  --role "Grafana Viewer" \
  --scope "$GRAFANA_ID"
  
# #add AMW monitoring contributor 
echo 'Grant Monitoring contributor to current user on Azure monitor workspace...'
az role assignment create \
  --assignee-object-id "$ME_OBJECT_ID" \
  --assignee-principal-type User \
  --role "Monitoring Contributor" \
  --scope "$AMW_ID"

#link AMW to aks cluster 
echo 'Enabling Azure monitor metrics, configuring Grafana and monitor workspace...'
az aks update --enable-azure-monitor-metrics --name $CLUSTER_NAME --resource-group $RESOURCE_GROUP --azure-monitor-workspace-resource-id $AMW_ID --grafana-resource-id  $GRAFANA_ID

