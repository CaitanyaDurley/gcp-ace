# Create a GKE cluster
```sh
# Create a cluster called lab-cluster with 3 nodes
gcloud container clusters create --machine-type e2-medium --zone $ZONE lab-cluster
# Authenticate with the cluster - so kubectl works
gcloud container clusters get-credentials lab-cluster
```

# Deploy an application
```sh
# Create a new deployment from the hello-app container image
kubectl create deployment hello-server --image=gcr.io/google-samples/hello-app:1.0
# Create a Service to expose the application with a GCE load balancer
kubectl expose deployment hello-server --type=LoadBalancer --port 8080
```

# Delete the cluster
```sh
gcloud container clusters delete lab-cluster
```
