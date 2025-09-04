# Challenge 04 - Creating & Running Chaos Experiments on AKS Nodes/Workload

[< Previous Challenge](./Challenge-03.md) - **[Home](../README.md)** - [Next Challenge >](./Challenge-05.md)

## Introduction

In this challenge, you will create experiments that mimic real world faults and run the experiments against AKS Worker Nodes/ Application Pods.

## Description

### Create following experiments in Azure Choas studio

- Experiment 01: **Spike the content-api pod CPU to 100**
   - Use system assigned identity & built in roles for experiment Permissions
   - Use "chaos mesh stress chaos" fault for this experiment
   - Use the json file in `/manifest/Challenge 04/` folder to create the experiment
   - Select the AKS cluster as Target Resource.


### Run the Experiments from Azure Portal 

- **NOTE:** Sample YAML files to get you started can be found in the `Manifests/Challenge-02/` folder.
- Configuration details:
  - Number of pods: 1
  - Service: Internal
  - Port and Target Port: 3001
  - CPU: 0.5
  - Memory: 128MB
- Make sure you correctly set the CPU & Memory resource requests specified above.


## Success Criteria

1. Verify you have the **API app** pod deployed and can get data from the `/speakers` endpoint.
2. Verify you have the **WEB app** pod deployed and can access its page from the open internet.
3. Verify the content init job created the db by exec into the **Mongo DB** pod and running the command "show dbs"
4. Verify the `/speakers` and `/sessions` pages display speakers and sessions respectively, not just blank pages.
