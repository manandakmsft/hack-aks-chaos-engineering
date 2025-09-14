# Challenge 05 - Setting up telemetry and performance dashboards

[< Previous Challenge](./Challenge-04.md) - **[Home](../README.md)** - [Next Challenge >](./Challenge-06.md)

## Introduction

In this challenge we will review resources created in Challenge 01 for investigating the performance and behavior of our cluster.
## Description
In this challenge we learn of the different monitoring options available for determining the health of your AKS cluster and what each service offers.  An Azure monitor workspace, Grafana and Prometheus instance are needed.


### Prometheus and Grafana: 
Prometheus provides time series metrics such as CPU, memory and network stats and Grafana is a visualization tool for the data from Prometheus.  Azure provides a managed offering for both so the customer does not have to install them in their cluster.  Prometheus scrapes metrics from your AKS cluster and store them in a time series store called Azure monitor workspace.  This is useful for historical trends such as before and after an app deployment what was latency on the app?

Grafana is used to visualize the metrics that Prometheus collects.  It offers a rich suite of visualizations, custom dashboards and alerts for keeping tabs on your AKS environment.  Both Prometheus and Grafana can be self-hosted in a cluster, however, Azure offers a managed version of both.

NOTE - we need to have the following permissions set in order for Grafana, Azure monitor workspace and Prometheus to function properly

`Grafana Viewer` role for the object id of the currently signed in user at the scope of the Grafana instance.

`Monitoring Reader` role for the object id of the Grafana managed identity, scoped to the Azure monitor workspace.

`Monitoring Contributor` for the object id of the currently signed in user, scoped to the Azure Monitor workspace.

***NOTE***
If you are completing the challenge through the portal, the command to get the object id of the logged in user may fail.  If so make sure you are logged into your account and run `az ad signed-in-user show --query id -o tsv` on your local machine, get the response and use that as an environment variable for assigning roles in the portal.



## Success Criteria

1. Azure monitor workspace created
2. Azure managed Prometheus created 
3. Azure managed Grafana created 
4. Grafana and Prometheus are linked to your AKS cluster
5. Access to managed Grafana dashboards
6. Grafana MI has monitoring reader permissions on Azure monitoring workspace
7. Current user has Grafana Viewer permissions
8. Current user has monitoring contributor permissions on Azure monitoring workspace

