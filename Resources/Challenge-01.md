# Challenge 01 - Deploying an AKS cluster

[< Previous Challenge](./Challenge-01.md) - **[Home](../README.md)** - [Next Challenge >](./Challenge-02.md)

## Introduction

Deploying an AKS cluster.

## Description
In this exercise we will create an AKS cluster with best practice settings.  The user can deploy the cluster via az cli, Azure portal, Terraform or ARM templates.  

## Success Criteria
Your cluster should be created and enabled with the following options - 

1. Cluster has a system and a user node pool
2. Cluster uses Azure CNI Overlay as netwokring
3. AAD Authentication enabled
4. Pricing tier - standard
5. Conatiner insights enabled
6. Workload identity enabled
7. Auto upgrade enabled
8. Cluster uses AZs