# Challenge 06 - Rearchitecting the application deployment to make it more reliable & resilient against failures

[< Previous Challenge](./Challenge-05.md) - **[Home](../README.md)** 

## Introduction

In this challenge based on the observations/learning we got from injecting controlled faults into the application & AKS nodes, we will re design the application/deployment to make it more resilient against failures.


## Description
Based on the chaos experiments that was conducted, below given are some of the design best practices which improves the application resiliency

- Use Persistent Volumes for Database. If not if a Pod gets deleted, all data is lost
- All applications should have multiple replicas. This way even if one of the nodes goes down, there is another replica which is serving traffic
- Spread the application on nodes which are in different AZ's using topology spread contstraints. This way even if one AZ goes down, application isnt fully unavailable.
- Use horizontal pod autoscaling to scale up the number of pods during peak traffic which causes cpu & memory of pods to spike
- Use cluster auto scaler to ensure that new pods created by HPA gets scheduled on a newly created node if existing nodes are full.
- Use liveness & readiness probes on the deployment. Readiness probe ensures a backend pod receive traffic only when its ready, while liveness probe ensures it stays healthy and restarts if it fails.

## Success Criteria

Go through the above Best practises and make changes to the app deployments to improve resiliency
