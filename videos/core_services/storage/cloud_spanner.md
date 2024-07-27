# Cloud Spanner
A relational database with non-relational horizontal scale.

## Features
1. Petabytes of capacity
1. Transactional consistency at global scale
1. Automatic synchronous replication
Used for financial and inventory applications.
SLA:
1. Multi-regional = 99.999%
1. Regional = 99.99%

## Architecture
A cloud spanner instance replicates data in _end cloud zones_ which can be within one region or across multiple regions.
This allows for HA without failover, as well as global placement.
Data replication is synchronised using Google's global fiber network.
Atomic clocks ensure adamiscity whenever you are making updates.

## How it works
1. Cloud spanner divides rows into chunks called _splits_. It does this based entirely on the `PRIMARY_KEY`
1. Splits can move freely between the available compute nodes to scale out reads and writes
1. It is guaranteed that there is only ever one node handling *writes* to a given split
### Hotspotting
This is when one node is consistently under heavier load than others.
An example is due to a monotonically increasing primary key.
The last split has to deal with all the writes, which exhausts the resources of the responsible node.
This can also cause slow reads, since e.g. a read for the last row has to wait until a pending write transaction completes.
The solution is to randomise the primary key.

## When to scale out
The recommended maximum CPU utilization for single-region Spanner instances is 65%.
When this threshold is exceeded, you should add more nodes to the Spanner instance and take advantage of Spanner’s horizontal scalability
