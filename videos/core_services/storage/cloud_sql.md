Cloud SQL is a fully managed service for:
1. MySQL
1. PostgreSQL
1. Microsoft SQL Server

Patches are automatically applied, but you still have to administer MySQL users with the native authentication tools that come with these databases.

## Client support
1. Cloud Shell
1. App Engine
1. Google workspace scripts
1. Any external app using standard MySQL drivers

## Performance
Up to:
1. 64TB of storage
1. 60,000 IOPS
1. 624GB of RAM per instance
1. Scale up to 96 CPU cores
1. Scale out with read replicas

## HA configuration
Within a regional instance, there is:
1. A primary instance in one zone
1. A standby instance in another zone
All writes made to the primary instance are replicated to the standby instance via synchronous replication to each zone's persistent disk.
The data must be replicated in both zones before a transaction is reported as committed.

During failover, the standby's persistent disk is attached to the instance, and it becomes the new primary instance.
Users are then rerouted to the new primary.

## Other features
1. Backup service with point-in-time recovery
1. Import and export databases with `mysqldump` or CSV files
1. Scale up (requiring a machine restart) or scale out with read replicas

## Connection types
If your application is hosted in the same GCP project and region, use Cloud SQL's private IP.
If your application is hosted in another project/region or outside GCP there are 3 options:
1. Cloud SQL Auth Proxy - handles authentication, encryption and key rotation for you
1. Manual SSL - generate and periodically rotate the certs yourself
1. Authorised networks - if you cannot use SSL, you can authorise a specific IP address to connect using the SQL server's external IP

## Other relational storage services
1. Memorystore - fully-managed in-memory data store for workloads requiring microsecond response times or have large spikes in traffic, e.g. gaming or real-time analytics
1. BigQuery - relational data store primarily used for analytics
1. Cloud Spanner - If your workload isn't analytics, but you need horizontal scaling and/or a globally available system
