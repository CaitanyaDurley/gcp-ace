1. You have several dev teams using GCP. How can you restrict your teams from creating GCP resources outside the US region?
    * Create a folder that contains all dev projects and limit resources in US locations using an Organisation policy - yes
    * Create an organisation that contains all the dev projects and limit resources in US regions using an IAM policy - no, IAM policies control who can access what, we need a (non-IAM) policy
1. You nneed to provide access to compute images and disks to an external member of your team in one of your projects. What is the Google-recommended approach?
    * Use the `Compute Image User` role as the base for a custom role and add the `compute.disks.list` to the `includedPermissions` field. Grant the custom role at the project level - yes, this provides the user with the precise permissions they need
    * Grant the `Compute Storage Admin` role at the project level - no, this provides more than just list access, violating least privilege
1. You need a Data Lake to process structured and unstructured data from millions of IoT devices. What option can be used to build a scalable and resilient architecture?
    * Use Dataflow to send data to GCS by streaming data into Pub/Sub - yes, Pub/Sub provides HA for streaming data and GCS provides durable storage for a data lake
    * Use Dataprep by Trifacta to send data to Bigtable by streaming data to Dataflow - no, Dataprep introduces unnecessary complexity
1. You have a monthly batch process that runs on an on-prem server and takes ~20h. The task can be restarted if interrupted. How to migrate to GCE while optimising costs?
    * Create a MIG using a template with Spot VMs and adjust target CPU utilisation - yes, a MIG opens the possibility for falut-tolerance and the number of VMs can be adjusted by changing the target CPU utilisation
    * Use a Spot VM - no, this would require manual handling for the monthly job and doesn't offer any fault tolerance
1. You are building a brand new app that needs to be deployed in three separate environments (dev, uat & prod). How can you deploy and manage these environments to ensure they are consistent?
    * Create one Terraform configuration for all envs and parameterise the differences between envs - no, manually parameterising the env differences is time-consuming and error-prone
    * Create one deployment template that will work for all envs using the Cloud Foundation Toolkit and deploy with Terraform - yes, CFT provides enterprise-grade templates for Deployment Manager and Terraform which follow Google-recommended practices. One deployment template that is compatible with all envs ensures consistency.
1. You have a set of dockerised microservices. How can you deploy them to GCP such that it can scale according to load and requires minimal administration.
    * Cloud Run - yes
    * GKE - no, more management than K8s
1. Your security team has found multiple users in your project whose email ids are from outside the Google Workspace domain. How can you ensure outside users don't receive access to your GCP projects?
    * Implement an organisation policy rule to restrict user identies based on their domains, enabling the automatic removal of users with inconsistent details - no, there is no "automatic removal" option, so this would not remove existing mismatched users
    * Enforce an organisational policy restriction to cap identities by domain, followed by the retrospective elimination of previously identified mismatched users - yes
1. One of the VMs in your MIG has unresponsive processes. How can you replace the VM quickly?
    * Use the `gcloud compute instances update` command, employing the REFRESH action - no, this only performs a soft reboot of the VM, it doesn't recreate it
    * Use the `gcloud compute instance-groups managed recreate-instances` command - yes, this terminates the VM and replaces it
1. You are using Config Connector and you have created a Pub/Sub topic using it. How can you permanently delete the Pub/Sub topic?
    * Use kubectl - yes, Config Connector is an open-source K8s add-on that lets you manage GCP resources through K8s tooling and APIs
    * Use gcloud - no, this may leave behind residual resources or configurations related to the topic
1. All employees at your startup have Google Workspace accounts. You are planning to 10x your employee count. What should you do to support this growth without performance degradation, unnecessary complexity or security issues?
    * Organise the users in Cloud Identity into groups and enforce MFA in Cloud Identity - no, doesn't handle the 10x employee count
    * Turn on identity federation between Cloud Identity and Google Workspace. Enforce MFA for domain-wide delegation - yes, identity federation allows seamless management and MFA provides security
1. One of the instances in your MIG failed to be created. What should you do to solve the problem?
    * Develop an instance template with an appropriate structure for utilisation in the MIG. Ensure the removal of persistent disks sharing names with instance identifiers - yes, here "appropriate structure for utilisation in the MIG" means the disk name is distinct from the instance name. This will hence work
    * Validate the correctness of the instance template. Eliminate persistent disks mirroring instance names. Adjust the instance template to include the `disks.autoDelete` property set to true - no, while this would work, it overlooks that you can't "adjust" isntance templates
    * Any option that doesn't explicitly mention eliminating persistent disks with the same name as an instance - no