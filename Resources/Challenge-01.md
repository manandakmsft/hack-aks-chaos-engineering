# Challenge 01 - Deploying an AKS cluster

[< Previous Challenge](./Challenge-01.md) - **[Home](../README.md)** - [Next Challenge >](./Challenge-02.md)

## Introduction

Deploying an AKS cluster.

## Description

In this challenge we will use the az cli to deploy an ARM template of an AKS cluster.

### ARM templates:
The ARM template files for deploying the AKS cluster can be found in `Solution/Challenge 01` folder.  If you wish to change the location, cluster name or AKS version, find those values in the `Solution/Challenge 01/parameters.json` file and make the changes you wish.  Inspect the template.json file to get an idea of what the configuration looks like.

### Deploying the ARM template:
Run `az account show` to make sure you are logged into your user account.  If you are not logged in, run `az login`.
You can choose an existing resource group, or create a new one for this exercise.  Run `az group create --location <location> --resource-group <resource-group-name>` to create a resource group.
To create your AKS cluster run `az deployment group create --resource-group <resource-group-name> --template-file /path-to/template.json --parameters @path-to/parameters.json`

## Success Criteria

1. Your az cli command begins to invoke.
2. The command completes succesfully after ~5 minutes.