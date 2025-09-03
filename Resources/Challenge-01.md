# Challenge 01 - Deploying an AKS Cluster

[**[Home](../README.md)** - [Next Challenge >](./Challenge-03.md)

## Introduction

In this challenge, we will deploy an Azure Kubernetes Service (AKS) cluster for hosting our application and learn some of the core components of how AKS works.

## Description

In this exercise we will learn about some best practices when deploying AKS for production ready scenarios.  We will discover some of the core components, what they do and why we choose one configuration over another, and where these things are in the Azure portal.  We will configure options in the Azure portal, export the configuration to an ARM template and use the az cli to create the cluster.

##High level terminology 
- API server - this is the brain of kubernetes.  It is want runs, schedules and maintains desired state of your cluster.  This is managed by Microsoft and is not configurable by the customer.
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
- Network configuration - how you want workloads running on your nodes to talk to each other.  Azure CNI overlay is best practice, except for particular scenarios where pods in other vnets need to talk to each other
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

### Cluster preset configuration:

- This is not a native option to Kubernetes, rather it's a higher level concept that gives reasonable defaults based on your intended purpose when you create the cluster.

##Dev/Test
- This option is intended for demos, POCs and a playhground for when you want to test things out.  This should never be used for a production scenario with real, mission critical applications running.  It offers the minimal compute and redundancy to save money.


##Why we wouldn't use this for a real life scenario

### Deploy the **API app** from the command line using kubectl and YAML files:

- **NOTE:** Sample YAML files to get you started can be found in the `/Challenge-02/` folder.
- Configuration details:
  - Number of pods: 1
  - Service: Internal
  - Port and Target Port: 3001
  - CPU: 0.5
  - Memory: 128MB
- Make sure you correctly set the CPU & Memory resource requests specified above.
- We have not exposed the API app to the external world. Therefore, to test it you need to:
	- Figure out how to get a bash shell on the API app pod just deployed.
    	- _Hint: Review the kubernetes docs for instructions, or feel free to use a GUI tool_
	- From the terminal, curl the url of the `/speakers` end point.
	- You should get a huge json document in response.
   
### Deploy the Web app from the command line using kubectl and YAML files
- **NOTE:** Sample YAML files to get you started can be found in the `/Challenge-02` folder.
- **NOTE:** The Web app expects to have an environment variable pointing to the URL of the API app named:
	- `CONTENT_API_URL`
- Create a deployment yaml file for the Web app using the specs from the API app, except for:
	- Port and Target Port: 3000
- Create a service yaml file to go with the deployment
	- **Hint:** Not all "types" of Services are exposed to the outside world
- **NOTE:** Applying your YAML files with kubectl can be done over and over as you update the YAML file. Only the delta will be changed.
- **NOTE:** The Kubernetes documentation site is your friend. The full YAML specs can be found there: <https://kubernetes.io/docs>
- Find out the External IP that was assigned to your service. You can use kubectl for this, or you can look at 'Services' in the Azure portal.
- Test the application by browsing to the Web app's external IP and port and seeing the front page come up.
	- Ensure that you see a list of both speakers and sessions on their respective pages.
	- If you don't see the lists, then the web app is not able to communicate with the API app.

## Success Criteria

1. Verify you have the **API app** pod deployed and can get data from the `/speakers` endpoint.
2. Verify you have the **WEB app** pod deployed and can access its page from the open internet.
3. Verify the content init job created the db by exec into the **Mongo DB** pod and running the command "show dbs"
4. Verify the `/speakers` and `/sessions` pages display speakers and sessions respectively, not just blank pages.
