# Hack- Chaos Engineering in AKS using Azure Chaos Studio

## Introduction

As monolithic applications evolved into microservices deployed on Azure Kubernetes Service (AKS), they introduced new challenges impacting application reliability. Scenarios such as Availability Zone (AZ) outages, nodes under high CPU, memory, or disk I/O pressure, network latency, or DNS resolution failures can all significantly affect application performance and availability.

To ensure resilience, it’s critical to proactively validate these applications by injecting controlled faults into AKS using Azure Chaos Studio.

## Learning Objectives

In this hack, you will gain hands-on experience with Azure Kubernetes Service—deploying workloads/applications on AKS and leveraging Azure Chaos Studio. You’ll design and run chaos experiments that simulate real-world failure scenarios, helping you measure application resiliency, uncover weaknesses, and re-engineer workloads for improved reliability.

## Challenges

- Challenge 01: **[Deploying an AKS cluster](Resources/Challenge-01.md)**
	 - Deploy a production grade AKS cluster using ARM template
- Challenge 02: **[Deploying a three-tier application on AKS](Resources/Challenge-02.md)**
	 - Deploying a three-tier application on AKS. The application contains a frontend , backend and a mongodb database using Persistant Storage.
- Challenge 03: **[Installing Chaos Mesh in AKS and registering the cluster as a target in Azure Chaos Studio](Resources/Challenge-03.md)**
	 - Install chaos mesh in AKS and adding AKS cluster as target in Azure Chaos studio
- Challenge 04: **[Creating and executing chaos experiments to simulate failures at the application and AKS worker node levels](Resources/Challenge-04.md)**
	 - Create chaos experients using ARM templates and execute the experiemnts to simulate faults in the aplication
- Challenge 05: **[Setting up telemetry and performance dashboards for experiment insights using Azure Monitor and Managed Prometheus & Grafana](Resources/Challenge-05.md)**
	 - Setting up telemetry and performance dashboards for experiment insights using Azure Monitor and Managed Prometheus & Grafana
- Challenge 06: **[Rearchitecting the application deployment to make it more reliable & resilient against failures](Resources/Challenge-06.md)**
	 - Based on the results on chaos experiments, re design the application deployment to make it more reliable & resilient against failures
