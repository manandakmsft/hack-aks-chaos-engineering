# Challenge 04 - Creating & Running Chaos Experiments on AKS Nodes/Workload

[< Previous Challenge](./Challenge-03.md) - **[Home](../README.md)** - [Next Challenge >](./Challenge-05.md)

## Introduction

In this challenge, you will create experiments that mimic real world faults and run the experiments against AKS Worker Nodes/ Application Pods.

## Description

### Create following experiments in Azure Choas studio

#### Chaos Experiments targeting Application
- **NOTE:** Sample JSON to create an experiment can be found in the `Manifests/Challenge-04/` folder.
- **NOTE:** To learn more about supported parameters used by Chaos Mesh, refer https://chaos-mesh.org/docs/simulate-network-chaos-on-kubernetes/

- Experiment 01: Spike CPU on the content-api pod for 5 mins
- Experiment 02: Spike memory on the content-api pod for 5 mins
- Experiment 03: Simulate a pod failure on the Mongo DB Pod for 5 mins
- Experiment 04: Simulate a DNS failure on the content-api pod so that it fails to resolve an external Service (www.weatherapi.com) used to fetch weather information for 5 mins
- Experiment 05: Simulate a N/W latency on the content-api pod for 5 mins

#### Chaos Experiments targeting AKS Nodes

- Experiment 01: Bring Down all nodes of one AZ for 5 mins
- Experiment 02: Spike memory on the node for 5 mins
- Experiment 03: Spike cpu on the node for 5 mins
- Experiment 04: Spike disk IO on the node for 5 mins

## Success Criteria

1. Ensure the experiments are executed successfully
2. Check who the application behave while the experiments are running.
