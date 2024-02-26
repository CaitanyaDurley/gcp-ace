Cloud Bigtable is a *NoSQL Big data* database service.
This powers many core Google services including search, maps and gmail.

## When to use
Bigtable is designed to handle massive workloads at consistent low latency and high throughput.
So it's good for user/financial analytics and IOT.
Customers often choose Bigtable if:
1. They're working with more than 1TB of (semi) structured data
1. Data has high throughput or is rapidly changing
1. They're working with NoSQL data - this usually means transactions where strong relational semantics are not required
1. Data is time-series or has natural semantic ordering
1. Processing big data

## How to use
Bigtable has APIs to read/write through a data service layer like:
1. Managed VMs
1. The HBase REST server
1. A Java server using the HBase client
This is typically used to serve data to applications/dashboards/data services.
Data can also be streamed in through frameworks like:
1. DataFlow streaming
1. Spark streaming
1. Storm
Data can also be read/written through batch processes like:
1. Hadoop MapReduce
1. DataFlow
1. Spark