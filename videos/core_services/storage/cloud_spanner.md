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
