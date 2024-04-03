# Firestore
1. Fast
1. Fully managed
1. NoSQL
1. Highly scalable
1. Document DB

## Features
1. Firestore simplifies storing, syncing and querying data for mobile web and IOT apps at global scale
1. Client libraries provide live synchronisation and offline support
1. Integrates with Firebase to accelerate building serverless apps
1. ACID transactions - if any of the operations in the transaction fail, nothing is committed
1. Automatic multi-region replication and strong consistency
1. Run sophisticated queries against NoSQL data without performance degradation

## Cloud Datastore
Firestore is the next generation of Cloud Datastore.
Firestore can run in _Datastore mode_ for backwards compatibility - this lets you use Firestore's improved storage layer while keeping the system behaviour of Datastore.
### Datastore mode
Firestore in datastore mode removes the following Datastore limitations:
1. Queries are no longer eventually consistent - they are all strongly consistent
1. Transactions are no longer limited to 25 entity groups
1. Rights to an entity group are no longer limited to 1 per second
Datastore mode is good for new server projects
### Native mode
Firestore in native mode introduces new features:
1. Strongly consistent storage layer
1. Collection and document data model
1. Real-time updates
1. Mobile and web client libraries
Native mode is good for new mobile and web apps where backwards compatibility is not needed.

Existing Cloud Datastore users will be live upgraded to Firestore automatically at a future date.

## Choosing firestore
Choose firestore if:
1. Your schema might change and you need an adaptable DB
1. You need to scale to zero
1. You want low maintenance overhead scaling up to TB
If you don't need transactional consistency consider Cloud Bigtable.
