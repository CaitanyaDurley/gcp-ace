# GKE
GKE is a managed Kuberenetes solution provisioned on Google infrastructure.
It helps you:
1. Deploy
1. Manage
1. Scale
K8s environments on GCP.

## Container-optimised OS
Nodes use a container-optimised OS to run your workloads.
These OSs are:
1. Maintained by Google
1. Optimised to scale quickly
1. Have a minimal resource footprint

## GKE Autopilot
_Autopilot_ is a mode of operation in GKE in which Google manages your cluster configuration:
1. Nodes
1. Scaling
1. Security
1. Other preconfigured settings

## Auto-repair
This is a feature which repairs unhealthy nodes for you.
It will:
1. Periodically health check the nodes
1. If a node is determined to be unhealthy, GKE will:
    * Drain the node - i.e. cause its workloads to gracefully exit
    * Recreate the node

## Other features
1. _auto-upgrade_ - ensures your clusters are automatically upgraded with the latest stable version of K8s
1. Scaling the cluster itself
1. Integration with IAM, Operations suite, VPC and netowrking features, Cloud Build, Artifact registry
