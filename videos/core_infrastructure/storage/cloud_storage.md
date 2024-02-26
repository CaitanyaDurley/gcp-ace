_Cloud storage_ provides durable and highly available object storage.

## Object storage
A storage architecture that manages data as "objects", not as a file/folder hierarchy (file storage) nor as chunks of a disk (block storage).
Objects are stored in a packaged format which contains:
1. The binary form of the actual data
1. Relevant meta-data, e.g. date-created, resource type, permissiosn
1. A globally unique identifier - in the form of URLs

## Use cases
GCS allows customers to store any amount of data and retrieve it as often as needed.
Example use cases:
1. Serving website content
1. Archival and DR
1. Distributing large data objects to end users via _Direct Download_
1. Whenever BLOB (binary large-object storage) is needed, e.g.:
    * Photos/videos
    * Backup/archival
    * Storing intermediate results in processing workflows

## Buckets
Files in GCS are orgnanised into buckets.
A bucket needs a globally unique name and a specific geographic location where data should be stored.
E.g. if most of your users are in Europe, you'd probably want a GCP region in Europe or the EU multi-region.

## Immutability
Storage objects are immutable - with each change a new version is created.
A bucket can be configured to use _versioning_ , which means GCS will keep a detailed history of modifications of all objects in that bucket.
You can then restore to an earlier version of an object or permanently delete a version of an object as needed.
By default, versioning is off, and new versions overwrite the older versions.

## User access
Using IAM roles and ACLs can ensure users have access to only the resources they need.
IAM roles are inherited from project to bucket to object.

### ACL lists
Each ACL consists of two pieces of info:
1. The scope - who can access and perform an action, can be a user or group of users
1. The permission - what actions can be performed like read/write

## Lifecycle policies
Storing and retrieving large amounts of object data can quickly become expensive.
_Lifecycle management policies_ allow you to e.g.:
1. Delete objects older than 365 days
1. Delete objects created before 01/01/13
1. Only keep the 3 most recent versions of each object in a bucket htat has versioning enabled

## Storage classes and data transfer
There are four primary storage classes in GCS

### Standard storage
Best for:
1. Hot (frequently accessed) data
1. Data only stored for a breief period of time

### Nearline storage
Best for:
1. Infrequently accessed data - reading/modifying on average once per month or less
1. Backups or archiving
1. Long term multimedia content

### Coldline storage
Low cost option for storing infrequently accessed data.
Coldline storage is meant for reading/modifying data at most once every 90 days

### Archive storage
Lowest cost option, best for data accessed less than once a year:
1. Data archiving
1. Online backup
1. DR
Archive storage has higher costs for data access and operations in a 365 day minimum storage duration

### Common features
All four classes have these same characteristics:
1. Unlimited storage
1. No minimum object size requirement
1. Worldwide accessibility
1. Low latency and high durability
1. Geo-redundancy if data is stored in a multi-region or dual-region

### Auto-class
_Auto-class_ is a feature that moves data that is not accessed to colder storage to reduce costs.
It also moves data that is accessed to standard storage to optimise future accesses.

### Costing
GCS has no minimum fee - you pay for what you use.

### Encryption
Data is always encrypted on the server side before it's written to disk.
Data travellling between a customer's device and Google is encrypted by default using HTTPS/TLS

### Bring data into GCS
Many customers can do this using the cloud storage command from Cloud SDK.
You can also drag and drop through the cloud console.
For TB+ of data there are other options.

#### Storage transfer service
For online data, this service lets you import large amounts of data quickly and cost effectively.
You can schedule and manage batch transfers to GCS from:
1. Another cloud provider
1. Another cloud storage region
1. From a HTTPS endpoint

#### Transfer appliance
This is a rackable, high capacity storage server that you lease from GCP.
You connect it to your network, load it with data and ship it to an upload facility.
A single appliance can hold up to a petabyte of data.

#### Other GCP services
Many of GCPs products and services can pull/push data from GCS.
For example:
1. Import and export tables to/from BigQuery or Cloud SQL
1. App engine logs/backups/objects 
1. GCE instance start up scripts/images/objects
