# Challenge 03 - Deploy Chaos Mesh into the AKS cluster

[< Previous Challenge](./Challenge-02.md) - **[Home](../README.md)** - [Next Challenge >](./Challenge-04.md)

## Introduction

In this challenge, you will deploy Chaos Mesh into your AKS cluster created in Challenge01. Chaos Mesh allows the introduction of simulated faults that would occur in real world scenarios.
## Description

### Set up Chaos Mesh on your AKS cluster:
Get credentials for AKS cluster and install Chaos Mesh into the cluster
`az aks get-credentials --admin --name <clustername> --resource-group <resource-group-name>`

`helm repo add chaos-mesh https://charts.chaos-mesh.org`

`helm repo update`

`kubectl create ns chaos-testing`

`helm install chaos-mesh chaos-mesh/chaos-mesh --namespace=chaos-testing --set chaosDaemon.runtime=containerd --set chaosDaemon.socketPath=/run/containerd/containerd.sock`


### Enable Chaos Studio on your AKS cluster
1. Open the Azure Portal
2. Search for Chaos Studio
3. Click on Targets and then the checkbox by your AKS Cluster
4. Click on Enable targets, then select Enable service-direct targets

### Enable Chaos Studio on your AKS NodePools ( VMSS)
1. Open the Azure Portal
2. Search for Chaos Studio
3. Click on Targets and then the checkbox the VMSS corresponding to the AKS Nodepools
4. Click on Enable targets, then select "Enable service-direct targets" & Enable agent based targets"

## Success Criteria

1. Verify a successful install of Chaos Mesh by running kubectl get pods -n chaos-testing and look for 1/1 under the Ready column of each pod.
2. Click on Manage Actions coresponding to the AKS cluster and VMSS you enabled as Targets and Check if the capabilities shows up.
