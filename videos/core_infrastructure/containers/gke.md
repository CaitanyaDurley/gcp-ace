GKE is a managed K8s service in the cloud.
The nodes in a GKE cluster and compute engine instances.
GKE clusters support different machine types, number of nodes, and network settings.
You interact with your cluster using K8s.

## Additional features
On top of standard K8s, GKE provides:
1. GCP's load balancing for GCE instances
1. Node pools to designate subsets of nodes within a cluster
1. Automatic scaling of the number of nodes in the cluster
1. Automatic upgrades for node software
1. Node auto-repair to maintain node health/availabilbity
1. Logging & monitoring with GCP operation suite