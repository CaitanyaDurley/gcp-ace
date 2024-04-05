# Logging
Cloud logging allows you to:
1. Store
1. Search
1. Analyse
1. Monitor
1. Alert
on log data/events from GCP and AWS.
It is fully managed and performs at scale (can ingest application and system logs from thousands of VMs).

## Features
Included with Cloud Logging is:
1. Storage for logs
1. A UI called Logs Explorer
1. An API to manage logs programatically

## Retention
Logs are only retained for 30 days. You may wish to export logs to:
1. GCS buckets - for persistent storage
1. BigQuery - analyse huge amounts of logs for stats such as network traffic
1. Pub/Sub - stream logs to applications or endpoints
