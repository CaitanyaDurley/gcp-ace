1. Want a small K8s cluster for dev. Cluster should only be available to team members and does not need to be HA. Need ability to change the cluster architecture as devs deploy new capabilities:
    * Private standard zonal cluster with a default pool and Ubuntu image - good
    * Autopilot cluster in us-central1-a with a default pool and Ubuntu image - don't need autopilot
    * Private standard regional cluster in us-central1 with a default pool and container-optimised image - container-optimised image doesn't support custom packages
    * Autopilot cluster in us-central1 with Ubuntu image - don't need autopilot
1. Need a GCS bucket serving users in NYC and San Fransisco. Users in London will not use this bucket. You don't plan on using ACLs:
    * `gsutil mb` command with a multi-regional location and an option to turn ACL evaluation off - gsutil is deprecated
    * `gcloud storage buckets create` specifying `--placement us-east1,europe-west2` - dual-region placements must be in the same continent
    * `gcloud storage buckets create` do not specify `--location` - default is multi-region US, so good
    * `gcloud storage objects` specifying `--remove-acl-grant` - not a valid flag
1. Need to load slowly changing data into BigQuery. Data arrives hourly in a GCS bucket. Want to minimise cost and implement in the fewest steps:
    * Create a Cloud Function to push data through a Dataflow pipeline - not fewest steps
    * Read the data from your bucket using the BigQuery streaming API in a program - not streaming data
    * Use the BigQuery data transfer service to schedule a pull from your bucket - simple and free
    * Implement a `bq load command` in a script and schedule with cron - not production ready
1. Have an on-prem medium sized MySql DB including user-defined functions. Want to migrate to GCP in most timely and economical way:
    * Find a MySql machine image in Cloud Marketplace and configure it to your needs - configuration is timely
    * Implement a GCE instance with `e2-standard-8` machine type, then install and configure MySql - configuration is timely
    * Configure a VM with `n2` machine type, then install MySQL and restore your data to it - fast and easy
    * Implement a DB instance using Cloud SQL, back up your local data, and restore to new instance - Cloud SQL does not support user-defined functions
1. Need to update OS of instances in MIG. Should be automated and use minimal resources:
    * Create a new instance template, set update type to PROACTIVE - proactive will apply updates automatically
    * Abandon each of the instances, delete the instance template, replace it, recreate the instances - not automated
    * Create a new instance template, set max surge to 5 - creates 5 new machines at a time - not economical
    * Create a new instance template, set update type to OPPURTUNISTIC - oppurtunistic means updates will only be applied when you manually say so or when new instances are created (e.g. when an autoscaler resizes)
1. Need a cloud function to act on files being added to a GCS bucket:
    * `--trigger-event google.storage.object.finalize` - when a new object is created OR an exiting object overwritten - good
    * `--trigger-event google.storage.object.add` - not a valid event
    * `--trigger-event google.storage.object.change` - objects can't be modified
    * `--trigger-event google.storage.object.create` - not a valid event
1. Want Cloud SQL with automatic failover in case of a zone outage:
    * `gcloud sql instances create --replica-type` - used in conjunction with master-instance-name to specify the type of replica: the default is READ, and the only other option is deprecated
    * `gcloud sql instances create --availability-type` - either regional (for automatic failover) or zonal (for no failover, and the default)
    * `gcloud sql instances create --secondary-zone` - not a valid option
    * `gcloud sql instances create --master-instance-name` - name of the instance which will act as the master in the replication setup. The newly created instance will be a read replica. This doesn't help with HA
1. Pick two tasks part of configuring a MIG:
    * Configuring the OS - no
    * Providing number of instances - yes
    * Specifying persistent disks - part of the instance template definition
    * Defining health checks - yes
    * Choosing instance machine type - part of the instance template definition
1. You want to delete a scheduled snapshot:
    * Restore the snapshot to a persistent disk before deleting it - no
    * Detach the snapshot schedule before deleting it - yes
    * Delete the object the snapshot was created from - no
    * Delete the downstream incremental snapshots before the main reference - not required and a lot of manual work
1. Want to implement a lifecycle rule that changes your storage type from standard to nearline after a sepcific date. What two conditions should you use:
    * MatchesStorageClass - yes, to look for objects with a standard storage type
    * CreatedBefore - yes, to find objects created before the given date
    * IsLive - no
    * NumberofNewerVersions - no
    * Age - no, we want a specific date
1. Which Cloud Audit log is disabled by default (with a few exceptions):
    * Data Access - yes, except for BigQuery
    * System Event - no, always written
    * Admin Activity - no, always written
    * Policy Denied - no, always written
1. You have a custom role for administration of the dev/test env of an application. You want to ensure your adminitrators have the correct access to new resources:
    * Make the change to the custom role locally and run an update on the custom role - yes, the recommended process to update an existing custom role is to get the current policy, update it locally, and write the updated policy back into GCP
    * Copy the existing role, add the new permissions to the copy, and delete the old role - no
    * Delete the custom role and recreate a new custom role with the required permissions - no
    * Create a new role with needed permissions and migrate users to it - no, finding all users with this role and reassigning them would be very time consuming
1. Writing a mobile app that needs to access non-private data from Pub/Sub. What kind of credentials should be used:
    * Service account key - yes, it's application authentication for non-user data
    * Environment provided service account - no, how would the environment provide it
    * API key - no, API keys authenticates against an API, but does not do any authorisation with IAM (since it doesn't identify a principal). They should only be used for accessing public data/resources
    * OAuth 2.0 client - no, an OAuth client lets an application access private data on behalf of an end user