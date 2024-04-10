# Kubernetes Concepts
## Object model
Each thing that Kubernetes manages is represented by an object.
Formally, a Kubernetes object is defined as:
1. A persistent entity
1. Representing something running in the cluster
1. Its desired state - defined by the _object spec_
1. Its current state - known as the _object status_
### Control plane
The _kubernetes control plane_ refers to the various system processes that collaborate to make a K8s cluster work.
### Object kinds
Each object is of a certain type, or _Kind_.
#### Pods
Pods are the smallest deployable K8s object.
A pod represents the environment where containers live - that environment can accommodate one or more containers.
If a pod has more than one container, those containers are tightly coupled and share resources including:
1. Network namespace:
    * The pod's (unique) IP
    * The pod's ports
1. Storage - i.e. a set of storage volumes

## Watch loop
Kubernetes accepts a declarative configuration of the state objects should be in, and it will work to keep them in that state.
It does this by means of its _watch loop_.
