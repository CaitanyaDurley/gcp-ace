# Services
Services provide load-balanced access to specified Pods.
There are three primary types of services:
1. ClusterIP - exposes the service on an IP only accessible from within the cluster. This is the default
1. NodePort - exposes the service on the IP of each node in the cluster, on a specific port
1. LoadBalancer - exposes the service externally via a load balancing service provided by the cloud provider

In GKE there are two types of LoadBalancer-like offerings:
1. LoadBalancer - regional network load balancer
1. Ingress Object - global HTTP(s) load balancer
