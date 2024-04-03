# Cloud Bigtable
If you need petabyte-scale and very low latency (sub 10ms), but you don't need transactional consistency, consider Bigtable.
It seamlessly scales for throughput and learns to adjust to specific access patterns.
High read and write throughput.
Good storage engine for ML models.

## Storage model
Data is stored in massively scalable tables.
A table is a sorted key/value map.
Each row is indexed by a single row key, and columns related to each other are typically grouped together into a _column family_.
Each column is identified by:
1. The column family it belongs to - e.g. a "friends with" group for a social media table
1. A column qualifier - a name unique within the column family. Note that column qualifiers are used as data themselves, e.g. "jadams" in the "friends with" group
New column qualifiers can be added as your data changes.
Each row/column intersection can contain multiple cells/versions at different timestamps - providing a record of how the data has been changed over time
Tables are sparse - if a cell does not contain any data, it does not take up any space.

## Architecture
Processing is separated from storage.
Processing is handled via a front-end server pool.
Storage is handled by the Colossus file system.
A Bigtable table is sharded into blocks of contiguous rows, called _tablets_, to help balance query workloads.
Tablets are stored in SSTable format - provides a persistent, ordered immutable map from keys to values, where both keys and values are arbitrary byte strings.

## Learn access patterns
If a certain node is frequently accessing a subset of data, Bigtable will update the indexes so that other nodes can distribute that workload more evenly. The data itself does not need to be moved.

## Throughput
The queries per second scales linearly with the number of nodes you add, up to hundreds of nodes.
The smallest Bigtable cluster you can create has 3 nodes and can handle 30K operations per second.
Nodes are paid for while operational, regardles of whether they are being used or not.
