1. You are using Ubuntu for developing HRMS software on GCP. You installed the Cloud SDK using the GCP Ubuntu package repository. Your application uses Cloud Datastore as its database. How can you test this app locally without deploying to GCP?
    * Use `gcloud datastore export` to export Datastore data - no, used to export data from Cloud Datastore
    * Use `gcloud datastore indexes create` to create a Cloud Datastore index - no
    * Install the `google-cloud-sdk-datastore-emulator` component using the `apt get install` command - yes, when you install the GCP SDK using `apt`, the SDK's _component manager_ is disabled and you must install extra packages using `apt`
    * Install the `cloud-datastore-emulator` component using the `gcloud components install` command - no, this would give the error `You cannot perform this action because the Cloud SDK component manager is disabled for this installation`
1. Your data science team use GKE for running ML pipelines. Some of the long-running, non-restartable jobs in a few pipelines require the use of GPUs. How can you fulfill the request at an optimal cost?
    * Use the cluster's node auto-provisioning feature - yes, node auto-provisioning is a mechanism of the Autoscaler which can extend a node pool.
    * Add a VerticalPodAutoscaler to those workloads - no, does not provision GPUs
    * Add a node pool with preemptible VMs and GPUs attached to those VMs - no, non-restartable jobs
    * Add a node pool of instances with GPUs, and enable autoscaling on this node pool with a minimum size of 1 - no, doesn't optimise cost
1. You have been assigned to facilitate an external audit of your travel booking application hosted on GCP. Auditor needs perms to review your GCP Audit Logs and Data Access logs. What IAM should you provide?
    * Provide the auditor with the IAM role `roles/logging.privateLogViewer` and export logs to GCS - no, there is no need to export logs to GCS
    * Provide the auditor with the IAM role `roles/logging.privateLogViewer` and direct the auditor to also review the logs for changes to IAM policy - yes, this role is required to view data access logs
    * Provide the auditor with a custom role with the `logging.privateLogEntryies.list` permission and export logs to GCS - no, listing insufficient
    * Provide the auditor with a custom role with the `logging.privateLogEntryies.list` permission and direct the auditor to also review the logs for changes to IAM policy - no, listing insufficient
1. Your company hosts its web and mobile apps on GCP. You are responsible for managing GCP costs. You have identified that a certain division has several services configured but are not using them. What should you do to turn off all configured services in the GCP project?
    * Make sure you have the Project Owner IAM role for this project, then navigate to the project in the Console, click Shut Down, and enter the Project ID - want to turn off all services, i.e. shut down the project. This needs the Owner role
    * Make sure you have the Project Owner IAM role for this project, then navigate to the project in the Console, locate the resources and delete them - no, don't want to delete the resources
    * Make sure you have the Organisational Administrator IAM role for this project, then navigate to the project in the Console, click Shut Down, and enter the Project ID - no, Org Admin has insufficient permissions
    * Make sure you have the Organisational Administrator IAM role for this project, then navigate to the project in the Console, locate the resources and delete them - no, don't want to delete the resources
1. You have built an image search API services used by users globally. The app receives SSL TCP traffic on port 443. Which LB should you use to minimise latency for clients?
    * HTTPS LB - no, we are not dealing with HTTP(s) traffic
    * Network LB - no, doesn't terminate SSL, just L4 routing
    * SSL Proxy LB - yes, SSL offloading close to the users (globally), then using the Google network as much as possible
    * Internal TCP/UDP LB - no, need external LB
1. You receive an alert that a new instance creation failed to create new instances on a MIG used by your app. The app requires the number of active instances specified in the template to function properly. What should you do?
    * Ensure the instance template has valid syntax and delete any persistent disks with the same name as instance names - no, this is a temporary solution
    * Ensure the instance template has valid syntax and verify the instance name and persistent disk name are not the same in the template - no, this is part of creating a valid instance template, but doesn't yet fix our issue
    * Create a new instance template with a valid syntax and set disks.autoDelete=true. Then delete existing persistent disks with the same name as instance names and make a rolling update to the new template - yes, recall we can't update an existing template, so we must make a new one and perform a rolling update. autoDelete prevents this issue from reoccuring
    * Delete the current instance template and create a new one. Ensure the instance name and persistent disk name values are different in the template. Set the disks.autoDelete property to true in the template. - no, can't delete an instance template in use
