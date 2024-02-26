_Firestore_ is a database that is:
1. Flexible
1. Horizontally scalable
1. NoSQL

## Documents and collections
Data is stored in documents and organised into collections.
Documents can contain complex nested objects and subcollections.
Each document contains a set of key-value pairs.

## Queries
NoSQL queries can retrieve specific documents or all the documents in a collection matching your query params.
Queries can include multiple chained filters and sorting options.
Data is indexed by default so query performance is proportional to the size of the result set, *not the dataset*.

## Synchronisation
A connected device (running the firestore client library) will receive updates as they occur so the device stays in sync.
One-time fetch queries are also efficient.
The app will cache data that it is actively using, meaning the app can write/read/query data even when the device is offline.
When the device comes back online, Firestore synchronises any local changes back.

## Guarantees
1. Automatic multi-region data replication
1. Strong consistency guarantees
1. Atomic batch operations
1. Real transaction support

## Pricing
You're charged for each document read/write/delete you perform.
Queries are charged at one "document read" per query, whether the query returns data or not.
You're also charged for storage and egress.
There is 10GB of free network egress per month between US regions.
Firestore also has a free daily quota of:
1. 50K document reads
1. 20K document writes
1. 20K document deletes
1. 1GB of stored data
