# Cloud Storage
See [here](/videos/core_infrastructure/storage/cloud_storage.md) for other details.

## Key features
1. Scalable to exabytes
1. Time to first byte in ms
1. Very high availability across all storage classes
1. Single API across storage classes

## Objects not files
Cloud Storage is not really a file system, it's a collection of buckets you place objects into.
You can create directories, but they are just another object that points to other objects in the bucket.
Objects are accessed via specific URLs, and you cannot easily index all the "files" as you would in a filesystem.

## Location types
Each storage class provides 3 locations
### Region
A specific region.
Standard class storage used in a region is appropriate for storing data in the same location as GKE clusters or GCE instances that use the data.
Co-locating resources maximises performance and can reduce network charges.
### Dual-region
A specific pair of regions such as Finland and the Netherlands.
You still get optimised performance when accessing GCP products located in one of the associated regions, but you also get improved availability from storing data in geographically separate locations.
### Multi-region
A large geographic region such as the US.
Standard class storage used in multi-region is appropriate for storing data accessed around the world, e.g.:
1. Website content
1. Streaming videos
1. Content to support mobile/gaming applications

## Durability
All storage classes have 11 nines of durability (99.999999999%).
This means you won't lose data, but is distinct from availability, which is about having access to your data.

## Buckets
1. Must have a globally unique name
1. Cannot be nested
1. Cannot change the location type once created
1. Can set and change the default storage class for objects in the bucket

## Objects
1. Unless you specify the storage class, it inherits the default storage class of its bucket
1. No minimum size
1. Can change the storage class of an object

## Access
We can use IAM for the project to control which accounts can:
1. See the bucket
1. List the objects in the bucket
1. View the names of objects in the bucket
1. Create new buckets
IAM roles are inherited from project to bucket to object.
If finer control is needed, ACLs and signed URLs are available.
### ACL
You define who has access to your buckets and objects and what level of access they have.
Max number of ACL entries on an object or bucket is 100.
### Signed URLs
For some applications, it may be easier to grant limited-time access tokens that can be used by any user, rather than requiring account-based authentication.
Signed URLs provide a cryptographic key that gives time-limited read or write access to a bucket or object.
The URL is signed with a private key associated with a service account. When a request is received, GCS can verify that the URL was issued on behalf of a trusted security principal (i.e. the service account) and delgates its trust of that account to the holder of the URL.

## Classes
Recall the guidelines:
1. Archive for <1 read per year
1. Coldline for <1 read per 90 days
1. Nearline for <1 read per 30 days
1. Standard for >1 read per 30 days
### Autoclass
If your data has a variety of access frequencies, or the access patterns are unpredictable, consider using Autoclass.
This feature automatically transitions objects to appropriate storage classes based on the object's access pattern.
1. Whenever an object is accessed it is immediately moved to standard storage
1. After 30 days an object is moved to Nearline
1. After 90 days an object is moved to Coldline
1. After 365 days an object is moved to Archive
1. Once in Archive storage, an object remains there until accessed
When enabled on a bucket there are no charges for:
1. Early deletion
1. Retrieval
1. Storage class transitions

## Other features
### CSEK
Customer-supplied encryption keys can be used instead of Google-managed keys.
### Object lifecycle management
Automatically delete or archive objects.
Configuration is applied to a bucket, and the set of rules therein applies to all objects in the bucket.
When an object meets the criteria of one of the rules, the action is automatically performed.
Object inspection occurs in async batches so rules may not be applied immediately.
Also, updates to the lifecycle config may take up to 24h to come into effect.
### Object versioning
Maintain multiple versions of objects - you are charged as if each version were its own object.
Since objects are immutable, they are deleted/overwritten whenever a change is made to an object.
Object versioning is enabled/disabled at a bucket level.
Once it is enabled you can list/restore/permanently delete versions of an object as desired.
Turning versioning off on a bucket leaves existing object versions in place but stops accumulating new archived object versions.
### Directory sync
You can sync a VM directory with a bucket.
### Object change notifications
Can be configured using Pub/Sub.
### Strong global consistency
Performing a read immediately after a write/delete is strongly consistent, i.e.:
1. After a write (new object or overwrite) you will never get a 404 or stale data
1. After a delete, you will always get a 404
1. After creating a bucket or object, listing all buckets/objects will be correct since metadata ops are also strongly consistent
This holds regardless of from which location in the world you query from.
