## Task 1. Set a default compute zone
### Your compute zone is an approximate regional location in which your clusters and their resources live. For example, us-central1-a is a zone in the us-central1 region. Start a new session in Cloud Shell.

## Set the default compute region,

```
gcloud config set compute/region us-east5
```

Set the default compute zone,
```
gcloud config set compute/zone us-east5-a
```

Task 2. Create a GKE cluster

Run the following command:

Create a cluster

gcloud container clusters create --machine-type=e2-medium --zone=us-east5-a lab-cluster 

Task 3. Get authentication credentials for the cluster
After creating your cluster, you need authentication credentials to interact with it.

Authenticate with the cluster:
```
  gcloud container clusters get-credentials lab-cluster 
```

Task 4. Deploy an application to the cluster

To create a new Deployment hello-server from the hello-app container image, run the following kubectl create command:

kubectl create deployment hello-server --image=gcr.io/google-samples/hello-app:1.0


To create a Kubernetes Service, which is a Kubernetes resource that lets you expose your application to external traffic,
run the following kubectl expose command:

```
kubectl expose deployment hello-server --type=LoadBalancer --port 8080
```
```
kubectl get service
```


To view the application from your web browser, open a new tab and enter the following address, replacing [EXTERNAL IP] with the EXTERNAL-IP for hello-server.

http://[EXTERNAL-IP]:8080



Task 5. Deleting the cluster
To delete the cluster, run the following command:
```
gcloud container clusters delete lab-cluster 
```
