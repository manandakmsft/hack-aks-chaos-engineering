# Challenge 05 - Setting up telemetry and performance dashboards

[< Previous Challenge](./Challenge-04.md) - **[Home](../README.md)** - [Next Challenge >](./Challenge-06.md)

## Introduction

In this challenge we will review resources created in Challenge 01 for investigating the performance and behavior of our cluster.
## Description
In this challenge we learn of the different monitoring options available for determining the health of your AKS cluster and what each service offers.



### Container Insights:
Uses a monitoring agent on your AKS nodes to collect stdout and stderr logs and kubernetes events.  Good for out of the box monitoring.
To view container insights in the Azure portal navigate to your AKS cluster created in challenge 01 and on the left hand menu go to `Monitoring => Logs`.  Click on the table button and mouse over ContainerLogV2 and in the query window run 

`ContainerLogV2 | where ContainerName contains "chaos"`.  This shows logs from Challenge 03 where we installed Chaos Mesh.  Check the `KubeEvents` table for even more details.

### Prometheus and Grafana: 
Prometheus provides time series metrics such as CPU, memory and network stats and Grafana is a visualization tool for the data from Prometheus.  Azure provides a managed offering for both so the customer does not have to install them in their cluster.  To see these offerings in action, in the Azure portal navigate to your AKS cluster from Challenge 01 and in the left hand menu navigate to `Monitoring => Dashboards with Grafana`.  View the default options available.  Click on `Kubernetes | Compute Resources | Cluster`.  Notice the rich amount of information available out of the box.  Throughout the exercise, refer back to the dashboards and see how they change over time and new workloads are deployed to the cluster


## Success Criteria

1. You can use KQL to query view logs from deploying.
2. You can view Grafana dashboards and see a high level view of your cluster and workloads running in it.
