# K8s
Kubernetes is an open source container management and orchestration solution.

## Features
It automates the following PaaS style features for containerised applications:
1. Deployment
1. Scaling
1. Load balancing
1. Logging
1. Monitoring
1. Other management features
Kuberenetes also facilitates a wide range of user preferences and config, like IaaS offerings.

## Declarative configuration
This is where you describe the desired state you want to achieve, instead of issuing commands to achieve it.
Kubernetes makes the deployed system conform to your desired state, and keeps it there even after failures.
This saves work, and reduces risk of error since the system's desired state is always documented.
Imperative configuration is generally only used for:
1. Temporary fixes
1. As a tool to build declarative config

## Workload types
Kuberenetes supports:
1. Stateless applications - e.g. a web server
1. Stateful applications - where user and session data needs to be persisted
1. Batched jobs & daemon tasks

## Scaling
Kubernetes can automatically scale containers in/out depending on resource utilisation.
You specify the resource request levels and limits.
