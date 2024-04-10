# GKE
There is an open-source command called `kubeadm` that can automate much of the initial setup of a cluster.
However, if a node fails or needs maintenance, a human administrator still has to respond manually.
This is where a managed K8s service comes in.

## Modes of operation
There are two modes of operation for GKE.
Unless you have a specific reason, Google recommends you always use Autopilot mode.
### Autopilot
GKE manages the entire cluster's infrastructure, including:
1. Control plane
1. Node pools
1. Nodes
GKE will monitor and manage all operational aspects of the cluster such that your workloads always have a place to run.
This includes scaling, security and Day 2 operations.
### Standard
Standard mode has all of the same functionality as Autopilot, but you are responsible for the cluster's:
1. Configuration
1. Management
1. Optimisation - to suit your requirements

## Control plane
Whichever mode you use, GKE manages all the control plane components for us.
It exposes an IP to which we send Kube API requests, but the separate control plane and the components behind it are all abstraced away.

## Nodes
GKE creates nodes by launching GCE instances and registering them with the cluster.
You pay per hour of life of your nodes (excluding the control plane).
You choose your node machine type when creating your cluster:
1. The default is e2-medium offering 2vCPUs and 4GB of memory
1. The largest generally available is 416vCPUs
You can also choose a baseline minimum CPU platform to improve node performance:
1. GKE will never use a platform older than the baseline
1. If it picks a newer one (due to capacity constraints), you will not be charged more
For node configuration and management, it depends on the mode:
1. Autopilot - GKE manages node config, autoscaling, auto-upgrades, baseline security config, baseline networking config
1. Standard - you manage the underlying infra, including configuring the individual nodes
### Node pools
A node pool is a subset of nodes in a cluster that share a configuration (e.g. memory or CPU).
This provides a way to ensure workloadsrun on the right hardware - label them with a desired node pool.
You can also setup automatic node upgrades, repairs and cluster autoscaling at the node pool level.
### Reserved resources
Some of each node's CPU and memory are needed to run GKE and Kubernetes components.
So nodes with 15GB of memory won't have all 15GB available for use by pods.

## Zonal vs regional clusters
By default, a cluster launches:
1. In a single compute zone
1. With 3 identical nodes
1. All in a single node pool
### Regional cluster
To increase availability in the event of an entire zone going down, you can use a regional cluster.
The control plane and nodes are spread across multiple zones within a region.
It is guaranteed that application availability will withstand the loss of one or more (but not all) zones.
By default, a regional cluster is spread across 3 zones, each contining 1 control plane and 3 nodes.

## Private cluster
A zonal or regional cluster can be set up as a private cluster.
This means the entire cluster is hidden from the public internet.
Cluster control planes can be accessed:
1. Through an internal IP
1. By authorised networks through an external IP
Authorised networks are just IP ranges that are trusted to access the control plane.
Nodes have limited outbound access through Private Google Access to e.g. pull container images from Container Registry.
