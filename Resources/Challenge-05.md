# Challenge 05 - Setting up telemetry and performance dashboards

[< Previous Challenge](./Challenge-04.md) - **[Home](../README.md)** - [Next Challenge >](./Challenge-06.md)

## Introduction

In this challenge we will review resources created in Challenge 01 for investigating the performance and behavior of our cluster.
## Description
In this challenge we learn of the different monitoring options available for determining the health of your AKS cluster and what each service offers.  An Azure monitor workspace, Grafana and Prometheus instance are needed.

### Prometheus and Grafana: 
Prometheus provides time series metrics such as CPU, memory and network stats and Grafana is a visualization tool for the data from Prometheus.  Azure provides a managed offering for both so the customer does not have to install them in their cluster.  Prometheus scrapes metrics from your AKS cluster and store them in a time series store called Azure monitor workspace.  This is useful for historical trends such as before and after an app deployment what was latency on the app?

Grafana is used to visualize the metrics that Prometheus collects.  It offers a rich suite of visualizations, custom dashboards and alerts for keeping tabs on your AKS environment.  Both Prometheus and Grafana can be self-hosted in a cluster, however, Azure offers a managed version of both.

- **Steps:** 
  - Create an Azure monitor resource

  - Create an azure Managed Grafana Instance

  - Link Azure Monitor and Azure Managed Grafana to the AKS cluster


## Success Criteria

1. Azure monitor workspace created
2. Azure managed Prometheus created 
3. Azure managed Grafana created 
4. Grafana and Prometheus are linked to your AKS cluster
5. Access to managed Grafana dashboards


