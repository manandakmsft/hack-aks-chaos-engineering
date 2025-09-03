# Challenge 02 - Deploying a three-tier application onto AKS

[< Previous Challenge](./Challenge-01.md) - **[Home](../README.md)** - [Next Challenge >](./Challenge-03.md)

## Introduction

In this challenge, you’ll deploy a three-tier app with a MongoDB database at the backend, an API microservice powering the logic, and a sleek front-end (Web) to bring it all together

## Description

In this challenge we need to get our application up and running in Kubernetes. We will learn about Kubernetes configuration YAML files used to create the various Kubernetes resources that will be needed to run our app. We will give our containers resource requests and open the app up to the outside world so we can test it.

Container Images

- **Mongo DB:** `mongo`
- **API app:** `whatthehackmsft/content-api:v2`
- **Web app:** `whatthehackmsft/content-web:v2`

### Deploy the **Mongo DB** from the command line using kubectl and YAML files:

- Deploy a MongoDB container in a pod for v2 of the FabMedical app.  Use the official MongoDB container image from https://hub.docker.com/_/mongo
- Make sure you create 2 Persistant Volume Claims and attach it to mount paths "/data/db" & "/data/configdb"
- Confirm it is running with:
	- `kubectl exec -it <mongo pod name> -- mongosh "--version"`
 - Hint: MongoDB runs on port 27017
 - Create a service with name "mongodb" to go with the deployment
 - To populate the Data on the Mongo, run a job using the image "whatthehackmsft/content-init". The Job should have the below Env Varibale
 	- name: MONGODB_CONNECTION and value: mongodb://mongodb:27017/contentdb

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
 - Create a service with name "content-api" to go with the deployment
   
### Deploy the Web app from the command line using kubectl and YAML files
- **NOTE:** Sample YAML files to get you started can be found in the `/Challenge-02` folder.
- **NOTE:** The Web app expects to have an environment variable pointing to the URL of the API app named:
	- `CONTENT_API_URL`
- Create a deployment yaml file for the Web app using the specs from the API app, except for:
	- Port and Target Port: 3000
- Create a service yaml to go with the deployment
	- **Hint:** Not all "types" of Services are exposed to the outside world. Make the service Type "LoadBalancer"
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
