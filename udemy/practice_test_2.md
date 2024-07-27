1. Your app communicates with a licensing server on IP `10.194.3.41`. You need to migrate the licensing server to GCE, but you can't change your app's config to reach the licensing server at a different IP.
    * Reserve the IP as a static internal IP and assign it to the licensing server - yes
    * Reserve the IP as a static external IP and assign it to the licensing server - no, 10.* are not publically routable IPs
1. You are migrating your app to a Linux VM and your MySQL DB to Cloud SQL. Your security team has created a service account with the approrpriate permissions.
    * Specify the service account under the "Identity and API Access" section when creating the VM via the web console - yes
    * Download a JSON private key for the service account and add it to the custom metadata of the VM for the key "compute-engine-service-account" - no, this is insecure (and also wouldn't work)
1. How can you connect to a Windows Server VM in the fewest number of steps?
    * Install an RDP client locally, set a Windows username and password in the console and then log in - yes
    * Set a Windows username and password in the console, verify a firewall rule for port 3389 exists and click the RDP button in the Console - no, to RDP into a Windows server you must have an RDP client installed locally. This answer would only work if that is the case
1. How would you view data access logs?
    * Go to the Audit log in the Console - yes, data access logs are a type of audit log
    * Go to Operation Suite and filter the logs - no, we want audit logs
NB: I think this is wrong, the Audit log page lets you choose what audit logs are logged, to view the logs you still need to go to the Operation Suite
1. Your app uses a MIG. Very little traffic is expected, so only a single instance of the VM should be active. How should you configure the MIG?
    * Autoscaling = on
      Minimum number of instances = 1
      Maximum number of instances = 1
      yes - autoscaling ensures recovery if a VM crashes
    * Autoscaling = on
      Minimum number of instances = 1
      Maximum number of instances = 2
      no - we want a max of 1 instance
1. Your finance team has asked you to create a new Billing account specifically for your project to track expenses. You need to link it with your project.
    * Ensure you have the Project Billing Manager IAM roles in your project, then create a new billing account and link it to the existing project - yes, the Project Billing Manager role lets you manage billing for the project
    * Ensure you have the Billing Administrator IAM role for the billing account, then link the existing billing account to a new project - no, we don't want to link an existing billing account to a new project
1. Your latest App Engine release needs to be rolled back.
    * Run `gcloud app restore` - no, not a valid command
    * Go to the App Engine page in the Console and click on revert - no, there is no specific option to revert to a previous version
    * Go to the App Engine Versions page in the Console and route 100% of the traffic to the previous version - yes, this is the fastest way to rollback
1. Your ops team require administrative access to GCE instances. You need to ensure credentials are optimally distributed to the ops team and that we can audit who accessed a given instance.
    * Let each member of the team generate a SSH key pair and send you their public key, then deploy those keys on each instance using a configuration management tool - no, every user is responsible for securing their private key, which is risky and not easily auditable
    * Let each member of the team generate a SSH key pair and add the public key to their Google account, then grant the `compute.osAdminLogin` role to the group corresponding to the ops team - yes
There are two ways to SSH into a Linux VM:
    * OS Login - if the Google account has the correct permissions, they are granted access. When you click the SSH button in the console, a short-lived key pair is generated and the public key is stored in your Google account.
    * Metadata managed (OS Login disables this) - usernames and public keys are stored in the metadata. When you click the SSH button in the Console, a key pair is generated with an expiry of 5 minutes and the public key is uploaded into the metadata. Under the hood, GCE syncs the metadata with the `authorised_keys` file on the VM
1. Your App Engine application runs in `us-central1`, how can you change the location to `asia-northwest1`?
    * Change the application's default region - no, changing the location of an existing application is not supported.
    * Create a new GCP project and create an App Engine app inside the new project with the new region - yes
    * Create a second App Engine app in the same GCP project with the new region - no, you can only have one App Engine app per project
1. You want your GCS hosted static website to show the contents of a PDF directly in the browser (rather than prompting the user to download it).
    * Use Cloud CDN to cache it - no
    * Set the `Content-Type` metadata to `application/pdf` on the objects - yes, this informs the browser the file is a PDF
1. You need to scale up a VM.
    * Perform a live migration to a machine with more memory - no, live migration never changes the VM's configuration
    * Stop the VM, increase the memory, start the VM - yes, you cannot change the RAM without stopping the VM
1. You are the cluster admin for a single GKE cluster on which multiple teams' apps run. You want to centralise monitoring for all teams via a single monitoring pod that sends container metrics to a third party monitoring solution. What is the simplest way to do this?
    * Deploy the monitoring pod in a StatefulSet - no
    * Deploy the monitoring pod in a DaemonSet - yes, a DaemonSet is deployed to every node, and container metrics can be obtained from every pod in the cluster
    * Ask developers to reference the monitoring pod in their deployments - no
