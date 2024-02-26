Kubernetes helps manage and scale containerised applications.
It makes it easy to orchestrate many containers on many hosts and deploy, rollout or rollback changes.
It is essentially a set of APIs you can use to deploy containers on the nodes in your cluster.

## Pod
A _pod_ is the smallest unit in K8s you can create/deploy.
A pod is a wrapper around one or more containers.
Generally a pod only has one container, but if you have multiple containers with a hard dependency, you can package them into a single pod to share networking and storage resources between them.
The pod provides a unique IP and set of ports for your containers and you can configure how the containers should run.

## Deployment
A _deployment_ is a group of replicas of the same pod.
K8s will keep your pods running even if the nodes they run on fail.

## Service
A service is an abstraction defining a logical set of pods and a policy by which to access them.
Pods (and their IPs) are ephemeral, whereas a service has a fixed IP address.
A service needs an external load balancer with a public IP attached to it so users outside the cluster can access it.
In GKE, the load balancer is a _network load balancer_.

## Rollout
Using a config like this
```yaml
spec:
    # ...
    replicas: 5
    strategy:
        rollingUpdate:
            maxSurge: 1
            maxUnavailable: 0
        type: RollingUpdate
```
will have Kubernetes roll out your new deployment one pod at a time, and wait for a new pod to become available before destroying one of the old pods.