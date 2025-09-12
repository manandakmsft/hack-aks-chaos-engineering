#!/bin/bash

# =========================
# Parameters (edit as needed)
# =========================
LOCATION="<location>"            # e.g., eastus
RESOURCE_GROUP="<rg>"
CLUSTER_NAME="<cluster-name>"
SYSTEM_POOL_NAME="systempool"
USER_POOL_NAME="userpool"
VM_SIZE="Standard_D4ds_v5"

# =========================
# Create Resource Group
# =========================
echo 'Creating resource group...'
az group create \
  --name $RESOURCE_GROUP \
  --location $LOCATION

# =========================
# Create AKS Cluster with system Node Pool
# =========================
echo 'Creating AKS cluster...'
az aks create \
  --resource-group $RESOURCE_GROUP \
  --name $CLUSTER_NAME \
  --location $LOCATION \
  --nodepool-name $SYSTEM_POOL_NAME \
  --node-count 1 \
  --node-vm-size $VM_SIZE \
  --enable-managed-identity \
  --enable-aad \
  --enable-workload-identity \
  --enable-addons monitoring \
  --network-plugin azure \
  --network-plugin-mode overlay \
  --outbound-type loadBalancer \
  --tier standard \
  --auto-upgrade-channel stable \
  --zones 1 2 3 \
  --generate-ssh-keys \
  --enable-oidc-issuer

# =========================
# Add User Node Pool with Autoscaling
# =========================
echo 'Adding user node pool...'
az aks nodepool add \
  --resource-group $RESOURCE_GROUP \
  --cluster-name $CLUSTER_NAME \
  --name $USER_POOL_NAME \
  --node-count 3 \
  --enable-cluster-autoscaler \
  --min-count 3 \
  --max-count 5 \
  --node-vm-size $VM_SIZE \
  --mode User \
  --zones 1 2 3



