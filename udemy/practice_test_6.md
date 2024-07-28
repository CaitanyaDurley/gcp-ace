1. You are building a news website to be accessed globally. How can you architect it to withstand a zonal failure?
    * Store the app data on a zonal persistent disk. During an outage, set up a new instance in another zone and attach the disk - no
    * Store the app data on a regional persistent disk. During an outage, set up a new instance in another zone and attach the disk - yes, recall a "regional" persistent disk provides active-active replicationa across two zones in the same region
    * Options using regular snapshots - no, could cause data loss
1. You are storing CCTV footage in GCS. Only the last 30 days of footage need to be kept. How can you save costs?
    * Change the storage class to Archive for objects with an age over 30 days using a lifecycle rule on the bucket - yes, while this doesn't delete the old footage, it is still much cheaper
    * Ensure versioning is enabled on the bucket and add lifecycle rules to expire non-current versions after 30 days - no, the concept of versions may not apply to our use case
1. You have a locally hosted data analytics toolkit, consisting of binaries, that handle data files in memory for ~50mins each night. The data can range from 1GB to 20GB. How can you migrate this to GCP with minimal effort and cost?
    * Package the binaries into a container and use Cloud Scheduler to trigger a Cloud Run task - no, containerisation is more effort and Cloud Run is intended for scaling workloads based on incoming traffic. It would be more expensive than a VM
    * Run the code in Cloud Functions and use Cloud Scheduler to initiate execution - no, we have binaries, and also Cloud Functions is designed for short-lived, stateless functions in response to events
    * Move the binaries to a GCE instance and implement an instance schedule to initiate and terminate the VM - yes, this is low effort and cost-effective
1. Where can you store a binary in Cloud Shell such that it persists across sessions?
    * `~/bin` - yes, the home directory is the only storage persisted across sessions
    * `/usr/local/bin` - no
1. You need to grant a Devops team administrative permissions to GCE in your project. They should not have access to any other resources in the project.
    * Provide the DevOps team with the `roles/viewer` basic role and assign them the predefined role `roles/compute.admin` - yes, the project Viewer role allows them to view all resources, which is typically safe and necessary for context
    * Develop an IAM policy with the complete range of `compute.instanceAdmin*` permissions. Associate this policy with the DevOps group - no, we may need other permissions (e.g. list permissions) and custom roles add complexity. Recall an IAM policy is just the combination of principal + role
1. You have a Dataproc cluster in a single subnetwork with range `10.18.20.128/25`. All available IPs have been used. How can you add new VMs in as few steps as possible?
    * Modify the subnet range to `10.18.20.0/24` - no, this changes the range from `10.18.20.128-255` to `10.18.20.0-255`, i.e. opens up space at the beginning rather than the end.
    * Create a secondary IP range in the VPC and configure the VMs so they can use the newly created range - no, by default the subnets wouldn't be able to communicate
    * Create a new VPC network and enable VPC peering between the VM's VPC network and the Dataproc cluster VPC network - no, need custom route exchange
    * Create a new VPC network for the VMs with a subnet of `10.18.21.0/24`. Use VPC peering between the two networks and configure a custom Route exchange - yes
1. An external company is merging with yours. How can you ensure the SREs in your company have the same project permissions in the other company's GCP organisation as in your own organisation?
    * Provide the startup's Organisation ID as the destination in the `iam roles copy` command - yes, this lets you copy custom roles between organisations
    * Provide the project IDs of all projects in the startup's organisation as the destination in the `gcloud iam roles copy` command - no
1. You need to grant a member of the security team the ability to view vulnerabilities and other OS metadata on a GCE instance. What is the recommended way to do this?
    * Install the Ops Agent on the instance. Create a custom metric in the Cloud Monitoring dashboard and provide access to the dashboard to the security team member - no, custom metrics are usually for monitoring application-specific metrics
    * Install the OS Config agent on the instance. Provide the `roles/osconfig.vulnerabilityReportViewer` permission to the security team member - yes, the OS Config agent is designed for OS configuration management and vulnerability reporting
1. Your company is exploring GKE. You want to calculate the resource requirements of a workload and learn how they vary with usage patterns. What is a Google-recommended solution that provides recommendations re costs, CPU & memory requirements while the workload consistently keeps functioning in any situation?
    * For availability configure the Horizontal Pod Autoscaler, and for suggestions configure the cluster autoscaler - no, the HPA provides HA but this doesn't address recommendations on cost-effectiveness or CPU/memory requirements of pods
    * Configure the Horizontal Pod Autoscaler, and for suggestions configure the Vertical Pod Autoscaler recommendations - yes, the VPA provides recommendations for individual pod resource requirements
1. You have a legacy application on GCP made up of a Flask webapp, a backend API & a scheduled long-running background job for ETL and reporting. How can you migrate this app to a serverless solution while keeping ops costs to a minimum?
    * Shift the webapp to App Engine, the backend API to Cloud Run and use Cloud Tasks to execute your background task on a GCE instance - no, a GCE instance is not serverless, and provisioning and managing the instance causes ops costs
    * Shift the webapp to App Engine, the backend API to Cloud Run and use Cloud Tasks to execute your background task within the Cloud Run environment - yes, this is fully serverless and cost-effective
    * Shift the webapp to a GCS bucket, the backend API to Cloud Run and use Cloud Tasks to execute your background task either on a GCE instance or within the Cloud Run environment - no, a GCS bucket is only suitable for hosting static websites (which our webapp may not be) and again mentions the use of a GCE instance
1. You want to migrate your CI/CD pipelines to GCE instances. How can you follow security best practices while ensuring the pipeline has the necessary permissions?
    * Attach one service account to the GCE instances, make sure the service account has minimal rights. Impersonate a Cloud Identity user through a service account with elevated permissions to create/update/delete resources - no, impersonating a Cloud Identity user through a service account is not recommended due to the greater risk should the pipeline be compromised
    * Attach one service account to the GCE instances. Make sure all required IAM permissions to create/update/delete resources are added to the service account - no, this leads to one service account with excessive permissions. A service account should have a single responsibility, with least privilege for that responsibility.
    * Add appropriate IAM permissions to multiple service accounts. Store the key files of the service accounts using a secret manager and request the appropriate secrets during the execution of the pipeline - yes, the secret manager ensures the keys are encrypted and access is logged and auditable.
1. How can you configure proxy settings for `gcloud` without credentials being present in the gcloud logs or on disk?
    * Use `gcloud config set proxy/username` and `gcloud config set proxy/password` - no, this may cause the credentials to be present in plaintext within the CLI configuration
    * Use the `CLOUDSDK_PROXY_USERNAME` AND `CLOUDSDK_PROXY_USERNAME` environment variables - yes
1. When submitting a query in BigQuery, the query fails with a "quotaExceeded" error. How can you identify and resolve the issue? (Choose two)
    * Use the INFORMATION_SCHEMA views - yes, this provides metadata about BigQuery resources including datasets, jobs and tables. From this you can understand the queries that have been run (e.g. high resource consumption)
    * Search errors in Cloud Audit Logs - yes
    * View errors in cloud monitoring - no, Cloud Monitoring is for monitoring performance and health rather than diagnosing errors
1. Your company wants to deploy a web portal on Cloud Run. The portal must only be accessible through an internal IP address within your private VPC and your on-prem network. What should be used?
    * Private Google Access - no, this is for accessing Google APIs and services. The portal would still have a public IP
    * Private Service Connect - yes, private service connect "is a capability of Google Cloud networking that allows consumers to access managed services privately from inside their VPC network"
