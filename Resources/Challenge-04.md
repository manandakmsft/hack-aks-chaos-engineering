# Challenge 04 - Creating & Running Chaos Experiments on AKS Nodes/Workload

[< Previous Challenge](./Challenge-03.md) - **[Home](../README.md)** - [Next Challenge >](./Challenge-05.md)

## Introduction

In this challenge, you will create experiments that mimic real world faults and run the experiments against AKS Worker Nodes/ Application Pods.

## Description

### Create following experiments in Azure Choas studio

#### Chaos Experiments targeting Application
- **NOTE:** Sample JSON to create an experiment can be found in the `Manifests/Challenge-04/` folder.
- **NOTE:** To learn more about supported parameters used by Chaos Mesh, refer https://chaos-mesh.org/docs/simulate-network-chaos-on-kubernetes/

- Experiment 01: **Spike CPU on the content-api pod**
- Experiment 02: **Spike memory on the content-api pod**
- Experiment 03: **Simulate a pod failure on the Mongo DB Pod**
- Experiment 04: **Simulate a DNS failure on the content-api pod so that it fails to resolve the Mongo DB Service**
- Experiment 05: **Simulate a N/W latency on the content-api pod**

## Success Criteria

1. Verify you have the **API app** pod deployed and can get data from the `/speakers` endpoint.
2. Verify you have the **WEB app** pod deployed and can access its page from the open internet.
3. Verify the content init job created the db by exec into the **Mongo DB** pod and running the command "show dbs"
4. Verify the `/speakers` and `/sessions` pages display speakers and sessions respectively, not just blank pages.
