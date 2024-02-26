Cloud SQL offers *fully managed relational databases*, including:
1. MySql
1. PostgreSQL
1. SQL server
as a service.

## Benefits
Cloud SQL hands off time-consuming tasks to Google, e.g.:
1. Applying patches/updates
1. Managing backups - 7 backups are included in the cost of an instance
1. Configuring replications

It does not require any software installation or maintenance.
It can scale up to 128 cores, 864GB of RAM and 64TB of storage

## Replication
It supports replication scenarios, e.g.:
1. From a Cloud SQL primary instance
1. From an external primary instance
1. From external MySQL isntances

## Security
Customer data is encrypted on Google's internal network and when stored in:
1. database tables
1. temporary files
1. backups
Cloud SQL includes a network firewall which controls network access to each database instance.

## Access
CloudSQL can be accessed using standard drivers.
GCE instances can be authorised to access Cloud SQL instancces and configure the Cloud SQL isntance to be in the same zone as your VM.
