# Challenge 01 - Deploying an AKS Cluster

[**[Home](../README.md)** - [Next Challenge >](./Challenge-03.md)]

## Introduction

In this challenge, we will deploy an Azure Kubernetes Service (AKS) cluster for hosting our application and learn some of the core components of how AKS works.

## Description

In this exercise we will learn about some best practices when deploying AKS for production ready scenarios.  We will discover some of the core components, what they do and why we choose one configuration over another, and where these things are in the Azure portal.  We will configure best practices in the Azure portal (including monitoring), export the configuration to an ARM template and use the az cli to create the cluster.

##High level terminology 
- API server - this is the brain of kubernetes.  It is want runs, schedules and maintains desired state of your cluster.  This is managed by Microsoft and is not configurable by the customer.  This is what you talk to when you want some action to be performed on the cluster.

- Pod - the smallest unit of deployment in AKS.  The AKS API server does not directly understand how to work with a container, but it uses a pod in order to schedule and run container images.
  
- Node pool.  A node pool is a virtual machine scale set (VMSS) behind the scenes.  This VMSS is the actual compute that your applications run on.  If enabled, node pools can be elastic (autoscaling) based on workloads running on the nodes.  For simple testing scenarios, one can disable autoscaling and have a fixed amount of compute in order to save money.
  
-  There are two types of node pools - system and user.  A system node pool is designed to NOT run customer applications, but components of the AKS cluster that are necessary for the cluster to work.  Some examples of what needs to run on system node pools networking and metrics.  A user node pool is fundamentally identical to a system node pool, but is designed to only run customer applications.  The reason for this is having dedicated nodes to running core components of AKS mean your application is not in contention for resources with those core components.  Under resource contention from your applications, the core system pods could be restarted which would incur downtime for the cluster.

##Portal options for AKS clusters

- Availability zones - geogrpaphical and logical containers of datacenters.  AZs exist at a distance to be geographically far enough away from one another that a natural disaster would not take down two at a time.  They have independent power and cooling from one another.  They are meant to maximum resiliency.  If this option is checked, AKS will place your API server and node pools across AZs.  This increases cost, but increases reliability.
  
- Long-term support (LTS) - if checked, the AKS version of the cluster will get two years vs one year of support.  Best to use if you cannot keep up with the pace of the community supported version.  There are no extras in functionality granted using this option, and is generally not recommended.
- Automatic upgrade - allows the user to configure when they want Azrue to initiate upgrades on their behalf.  This option will upgrade the AKS version of the cluster.
  
- Node security channel - allows the user to configure when a node image upgrade happens.  This option does not change the AKS version, but pulls updates to the latest image of the VHD (virtual hard disk).  Regularly updating the node image will help protect against vulnerabilities in the underlying OS.
  
- Authentication and Authorization - the mechanism for proving who you are, and what you are allowed to do.  The API server proves who you are, and RBAC is used to say what you can do

#Networking section
- Private cluster - if enabled, your cluster's API server will not have a public IP address.  This means the API server is not accessible from the public internet and any traffic from the control plane (API server) to your node pools reamains private.
  
- Authorized IP ranges - your API server has a public IP address, but is only accessible from a pre determined list of IPs.  This can be used when you want a public IP for simplicity's sake, but you want to make sure that only well-known IP addresses (VPNs, known networks) are allowed to talk to the API server.
  
- Network configuration - how you want workloads running on your nodes to talk to each other.  Azure CNI overlay is best practice, except for particular scenarios where pods in other vnets need to talk to each other.
  
- BYO virtual network - determines where the VMSS will be deployed.  The VMSS nodes have to live in a network somewhere.  Production clusters almost always will bring an existing vnet.
  
- Network policy - by default everything in kubernetes clusters can talk to everything else.  If you need to restrict this behavior, both Calico and Azure have their own language for allowing network policies.  Calico is more robust and performant and is preferred.

##Integrations - not native to kubernetes, but an area where functionality is extended 
- Azure Container Registry - a container registry is where you pull images from that will work your workloads.  In order to make sure the images you are running are secure, it's necessary for a user to create an ACR and place known safe images there.  Then, AKS will only have access to pull images from that known safe place, preventing malicious intent.
  
- Service mesh (Istio) - called an ingress controller, Istio provides networking for traffic from the outside world into the cluster itself.  This can also be installed by the customer in a non managed way.  In this way, the customer is responsible for keeping Istio up to date.
  
- Azure policy - when enabled, this runs pods that are capable of understanding Azure policy.  This allows the customer to defined a language with Azure policy that will enable or prevent certain actions from being allowed in the cluster based on OPA (open policy agent). An example would be disallow any pods without resource constraints from being deployed.

##Monitoring - how to know what is happening inside you cluster
- Enable container logs - send stderr, stdout to a log analytics workspace via Azure monitor agent.  Used when something like Datadog is not installed to get insights into what your workloads are doing.
  
- Prometheus - A platform for getting metrics from your workloads.  Designed for historival analysis.
  
- Grafana - a managed platform for visualizing the data generated from your cluster.

##Security - protect your workloads
- OpenID - uses OAuth for getting tokens to access Azure resources.
  
- Workload identity - allows fine grain access for certain pods to resources in Azure.
  
- Image cleaner - managed addon vesion of Image eraser.  Removes unused images from your AKS nodes for better performance, storage as well as remove a potential attack vector.
  
- Key Vault - allows AKS secrets to be safely stored outside of, then imported into the cluster.  

##How to deploy the AKS cluster

Over time deployment methods for deploying code assets have matured and most businesses use some sort of Infrastructure as Code (Iac).  IaC allows discoverable and repeatable build scripts that help enforce standards and reduce the opportunity for errors during deployment by entering the wrong value for a field.  When repeatable methods are used, one can be sure that the next time the code is run, the same result will occur (idempotency).  This helps ensure governance and can help with security be ensuring networking rules.  The most popular IaC tool to date is Terraform.

In this exercise we will explore the configuration options when creating an AKS cluster described above, and show how to generate an ARM template that is parameterized and can be reused to make incremental changes.

***Show some screen caps from the Azure portal on what options were selected when configuring the AKS cluster.  Show how to create the ARM template and download it.

