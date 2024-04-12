# Migrate for Anthos
What if you've got existing applications not in containers/the cloud?
_Migrate for Anthos_ is a tool for getting workloads into containerised deployments on GCP.
It is an automated process that moves your existing applications into a K8s environment from:
1. VMware (on prem)
1. AWS
1. Azure
1. GCE instances
Most migrations are completed in less than 10 mins.
Data can be migrated all at once, or "streamed" to the cloud until the application is live.

## Architecture
There are two steps to the migration.
### Migrate for Compute Engine
The first step is to allow _Migrate for Compute Engine_ to create a pipeline for streaming/migrating your data from on prem/another cloud provider into GCP.
This is a tool that allows you bring your application into VMs on GCP.
### Migrate for Anthos
The second step is to create a GKE processing cluster and install _Migrate for Anthos_ on it.
To install this, and execute the following steps, use the `migctl` command.
You will need to create a _migration object_ with the details of the migration you're performing.
This will generate a plan template for you in a YAML file, which you can alter as necessary.
You can then execute the plan to generate artifacts like:
1. K8s configs and Dockerfiles - stored in Cloud Storage
1. Container images - stored in Container Registry
The images being created here are just containers wrapping whatever would be present on a VM.
Both the container images and deployments will be tested at this stage.
### Deployment
Once the deployment assets are created and tests are successful, you can just deploy your application into a target cluster.
