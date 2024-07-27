1. You have a Data Studio dashboard that connects to BigQuery and visualises a table. A nightly BigQuery job recalculates the daily summary. The dashboard is broken, how can you debug?
    * Go to the BigQuery interface and review the nightly job for errors - yes, if a Data Studio report is broken, it probably means the data which it is connected to is broken
    * Go to Cloud Logging and create a filter for your Data Studio report - no, this will only show logs related to the report itself, not the underlying job
1. You have a GCP project with many devs and testers. The project contains some sensitive data and only certain members of the team should have access to it. How can you assign appropriate IAM roles to the participants such that minimum maintenance is required?
    * Create different groups and assign users to groups and a basic role to each group - no, basic roles will be too coarse-grained to restrict access to specific data (e.g. `Project Viewer`)
    * Create different groups and assign a custom role to each group, including those who should have access to sensitive data - no, custom roles will require lots of maintenance
    * Create differents groups and assign users to groups and an IAM predefined role to each group as required, including those who should have access to sensitive data - yes, predefined roles are fine-grained enough without causing unnecessary maintenance overhead (e.g. `instanceAdmin` on specific instances)
1. How can you ensure that all commands run from your local gcloud cli addressa specific K8s cluster by default?
    * Run `gcloud config set container/cluster` command - yes
    * Use `~/.gcloud/defaults.json` - no, this is not a valid configuration file
1. You have a Cloud SQL instance. The laws in your country require you to retain a month-end copy of the database for 3 years.
    * Create an export job that runs on the first of the month and writes the export file to a GCS bucket with the Archive class - no, there is no need for a manual job as automatic backups are a feature of Cloud SQL. Also requires manual removal of objects after three years.
    * Rely on the automatic first-of-the-month backup functionality. Set the bucket object auto-deletion to three years and use a bucket with the Archive class - yes, leverages Cloud SQL's automatic backup without manual intervention
1. Your company has recently started using Cloud Identity. Some employees already have a Google account under your organisation's domain. How can you avoid conflicting accounts with Cloud Identity?
    * Invite the user to transfer their existing account - yes, the existing account and data is retain, but now managed by Cloud Identity
    * Invite the user to use an email alias - no, the account won't be centrally managed from the Admin Console, and so defeats the purporse of Cloud Identity
