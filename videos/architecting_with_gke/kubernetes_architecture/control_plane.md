# Control plane
Recall the control plane is the fleet of cooperating processes that coordinate the cluster.
One computer in the cluster is also (confusingly) called the control plane and the others are called nodes.
We go through the control plane's components here and the role each plays.

## Components on the control plane
### kube-apiserver
This is the component you interact with directly.
It's job is to accept commands to:
1. View the state of the cluster
1. Change the state - including launching pods
It also authenticates incoming requests, authorises them and manages admission control.
#### kubectl
The `kubectl` command connects to the kube-apiserver and communicate with it using the Kubernetes API.
However, it's not just kubectl that talks with kube-apiserver. Any query or change to the cluster's state must be sent to the kube-apiserver.

### etcd
This is the cluster's database. It's job is to reliably store the state of the cluster, including:
1. All configuration data
1. What nodes are part of the cluster
1. What pods should be running and where
You never interact directly with etcd - kube-apiserver does this on behalf of the rest of the system.

### kube-scheduler
This is responsible for scheduling pods onto nodes. It does this by:
1. Evaluating the constraints of individual pods - e.g. a memory requirement on the node, or node affinity
1. Selecting the most suitable node
The scheduler doesn't actually launch the pod though. Instead, it writes the name of the selected node into the pod object.
Another component launches the pod on the selected node.

### kube-controller-manager
It continuously monitors the state of the cluster through kube-apiserver.
Whenever the current state of the cluster doesn't match the desired state, it will attempt to make changes to achieve the desired state.
#### Controllers
It's called the _controller-manager_ because many Kube objects are managed by loops of code called _controllers_.
For example, a Deployment object is a type of controller which keeps pods running and lets us scale them.
A _Node Controller_ monitors and responds when a node is offline.

### kube-cloud-manager
This manages controller that interact with the underlying cloud provider(s).
On GKE, the kube-cloud-manager would be responsible for bringing in GCP features like:
1. Load balancers
1. Storage volumes

## Components on each node
Each (non control plane) node also runs a small family of control plane components.

### kubelet
A kubelet is a Kubernetes agent running on each node.
When the kube-apiserver wants to start a pod on a node, it connects to that node's kubelet.
The kubelet:
1. Uses the container runtime to start the pod
1. Monitors its lifecycle
1. Performs readiness and liveliness probes
1. Reports back to kube-apiserver
#### Container runtimes
Kubernetes offers several choices for container runtimes.
The Linux distro used by GKE ndoes launches containers using `containerd` - the runtime component of Docker.

### kube-proxy
This maintains the network connectivity among the pods in a cluster.
In open-source K8s, it does so using the firewall capabilities of `iptables`.
We will learn how GKE handles pod networking later.
