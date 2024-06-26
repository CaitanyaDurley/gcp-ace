# Object management
All Kube objects are identified by:
1. A name - unique within all objects of the same kind (e.g. pods) in a namespace
1. A unique identifier - generated by K8s

## Manifest files
This is a yaml/json file in which you define the desired state for one or more objects.
You can define several related objects in the same file and it is best practice to do so.
```yaml
# apiVersion specifies which Kube API version is used to create the object
apiVersion: apps/v1
# kind defines the type of object
kind: Pod
# metadata helps identify the object using name, unique ID and an optional namespace
metadata:
    name: nginx
    # labels are key-value pairs for organisation
    labels:
        app: nginx
        env: uat
spec:
    containers:
    - name: nginx
      image: nginx:latest
```

## Controller object
Suppose we wanted 200 nginx pods as above.
Creating 300 yaml files is inconvenient and furthermore, pods don't self-heal - they are ephemeral and disposable.
Instead we can declare a controller object whose job is to manage the state of Pods:
1. Deployment
1. StatefulSet
1. DaemonSet
1. Job
Deployments are great for long-lived software components like web servers.
If one of the pods fails, the deployment controller will recoginise the difference between the current and desired state and launch a new pod.
```yaml
apiVersion: apps/v1
# kind defines the type of object
kind: Deployment
# metadata helps identify the object using name, unique ID and an optional namespace
metadata:
    name: nginx-deployment
    labels:
        app: nginx
        env: uat
spec:
    replicas: 3
    # template for the pods to be created by this deployment
    template:
        metadata:
            labels:
                app: nginx
        containers:
        - name: nginx
          image: nginx:latest
```

## Resource management
When K8s schedules a Pod, it's important that the containers have enough resources to run.
If the node has limited resources, things may stop working.
It's also possible for applications to use more resources than they should.
When specifying a Pod, you can specify how much of each resource (e.g. RAM, CPU) a container needs.

## Namespaces
Namespaces allow you to abstract a single cluster into multiple clusters.
They let you:
1. Provide scope for naming resources.
1. Implement resource quotas across the cluster
There are three initial namespaces in a new cluster:
1. default - your workload resources will use this by default
1. kube-system - for objects created by K8s itself
1. kube-public - for objects publically readable to all users. This lets you disseminate information to everything running in a cluster.
Namespaces can be specified either in the manifestof a resource, or on the cmd line.
To keep your YAML files more flexible, apply namespaces at the command line level wherever possible.
