# Private cluster
In GKE, a private cluster is where the master node is inaccessible from the public internet.
Nodes do not have public IPs, so your workloads run in an isolated environment.

## Create private cluster
To create a private cluster, you must:
1. Specify a `/28` CIDR range for the VMs that run the K8s master components
1. Enable IP aliases - this lets GKE automatically create a subnet for you
```sh
# Create the cluster
gcloud beta container clusters create private-cluster \
    --enable-private-nodes \
    --master-ipv4-cidr 172.16.0.16/28 \
    --enable-ip-alias \
    --create-subnetwork ""
# Find the subnet which was automatically created
gcloud compute networks subnets list --network default | grep gke-private-cluster-subnet
gcloud compute networks subnets describe <subnet name> --region $REGION
```
Note:
1. There are 2 secondary ranges - one for pods and the other for services
1. `privateIpGoogleAccess` is true - so your nodes can communicate with Google APIs and services

## Master authorised networks
Currently, the only IPs that can access the master are:
1. The primary range of your subnet. This is the range used for nodes
1. The secondary range of your subnet. This is the range used for pods
To provide additional access to the master, you must authorise selected address ranges.
```sh
# Create a source instance to check connectivity to the cluster
gcloud compute instances create source-instance --zone=$ZONE --scopes 'https://www.googleapis.com/auth/cloud-platform'
# Get the public IP
gcloud compute instances describe source-instance --zone=$ZONE | grep natIP
# Authorise that IP
gcloud container clusters update private-cluster \
    --enable-master-authorized-networks \
    --master-authorized-networks <IP>/32
```

## Connect to the master
```sh
# SSH into source-instance
gcloud compute ssh source-instance --zone $ZONE
# install kubectl
sudo apt-get install kubectl
# configure access to the cluster
sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin
gcloud container clusters get-credentials private-cluster --zone $ZONE
# Verify access
kubectl get nodes --output wide
```

## Custom subnet
Previously, we let GKE create a subnet for us. Here, we create our own custom subnet and then a private cluster.
```sh
# Create a subnet with secondary ranges
gcloud compute networks subnets create my-subnet \
    --network default \
    --range 10.0.4.0/22 \
    --enable-private-ip-google-access \
    --region=$REGION \
    --secondary-range my-svc-range=10.0.32.0/20,my-pod-range=10.4.0.0/14
# Create a private cluster using our subnet
gcloud beta container clusters create private-cluster2 \
    --enable-private-nodes \
    --enable-ip-alias \
    --master-ipv4-cidr 172.16.0.32/28 \
    --subnetwork my-subnet \
    --services-secondary-range-name my-svc-range \
    --cluster-secondary-range-name my-pod-range \
    --zone=$ZONE
```
