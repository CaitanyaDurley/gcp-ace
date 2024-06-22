1. You have an application on a GKE cluster with multiple replicas exposing a TCP endpoint. Another application on Compute Engine on a different VPC in the same region needs to access the application on GKE. How can you enable this access with minimum effort?
    * Create a LoadBalancer service and configure the GCE instance to use the address of the LB - no, this involves traffic going through the public internet
    * Create a LoadBalancer service with an annotation `cloud.google.com/load-balancer-type: Internal`, peer the two VPCs, and configure the GCE instance to use the address of the LB - yes, this is a valid annotation which instructs GCP to assign a private IP. After VPC peering it's good to go
1. You have a Cloud Run app that needs to consume messages from a Pub/Sub topic. What Google-recommended practices should you follow?
    * Grant the Pub/Sub Subscriber role to the service account used by Cloud Run and have the application pull messages from the subscription - no, we don't need to poll for updates
    * Create a service account, and give it the Cloud Run Invoker role. Create a Pub/Sub subcription that uses the service account and pushes to the Cloud Run endpoint - yes, this role allows a subscription to invoke your Cloud Run app
1. You want to deploy a container image in another GCP project to your GKE cluster. How can you ensure GKE can download images from the other project's Container Registry?
    * In the image project grant the Storage Object Viewer IAM role to the service account used by the K8s nodes - yes, Container Registry uses GCS buckets as the underlying storage for images. Access is controlled by granting GCS permissions.
    * Create a service account with access to Cloud Storage, create a P12 key for the service account and use it as an imagePullSecrets in K8s - no, using P12 keys for accessing container images can be a security risk. Also, this only grants access to GCS, not specifically to the Container Registry
1. Which role is needed to query a BigQuery dataset?
    * `jobUser` - yes
    * `dataViewer` - no, this allows users to read data/metadata, but not query it
1. Your GKE cluster has a single preemptible node pool. What might cause a deployment with 2 replicas to have one pod in Running status but another that is staying in Pending status?
    * Too many pods are already running; there are not enough resources left to schedule the pending pod - yes, this is why the pod can't be scheduled on the existing nodes
    * The pod was previously scheduled on another node that has been preempted. It will be rescheduled on a new node - no, this is true but doesn't answer why the pod is *staying* in Pending status. This is because there isn't a new node ready available to schedule on
1. Your website is experiencing latency due to repeated database queries. You need to implement a single caching HTTP reverse proxy. This specific proxy does not consume much CPU, but needs a 30GB in memory cache plus 2GB memory for the rest of the procs. How can you do this cost-effectively?
    * Use a Cloud Memorystore for Redis instance with 32GB capacity - yes, this is a fully managed Redis cache
    * Run the caching proxy on GCE with a custom instance type of 6vCPUs and 32GB memory - no, use the managed service instead. Also 6vCPUs is more than necessary
1. You are noticing read latency performance issues on a specific table. The table is only accessed using a primary key. The schema looks like
```sql
CREATE TABLE Users (
     user_id INT64 NOT NULL,     // sequential number based on registration number
     account_creation_date DATE, // system date
     firstname STRING (255),     // first name
     lastname STRING (255),      // last name
     birthdate DATE,             // user birthdate
     profile_picture BYTES (255) // user profile picture
) PRIMARY KEY (user_id)
```
* Remove the byte field `profile_picture` - no, you cannot query a byte field so removing it will not improve performance
* Make sure the primary key is not monotonically increasing - yes, this is an example of hotspotting
1. You have a 5TB AVRO file on GCS containing 5 years of user activity data. Your data analysis team need to access that data and are proficient in SQL. What is the most cost-effective way to fulfill their request quickly?
    * Create a BigQuery table and load the data in. Drop the table after the desired queries have been run - no, storage and processing costs would be high for loading this data in. Also, dropping the table would mean you have to reload the data if future queries are needed.
    * Create external tables in BigQuery that point to GCS buckets. Run the desired queries - yes, BigQuery supports external tables in Avro format
1. You are migrating an application from on-prem to GCP. The app requires 96vCPUs. How can you create a similar environment in GCP?
    * Use GCE machine type `n1-standard-96` - yes
    * Create the VM using default settings, and adjust as you go based on Righsizing Recommendations - no, we already know we need 96vCPUs, and rightsizing suggests based on usage (you might need more at peak times)
1. Your company has BigQuery tables in many projects. You need to find all datasets which contain a column called _employeeNumber_. How can you do this with minimum effort?
    * Search for _employeeNumber_ in the search box in the Data Catalog - yes, the data catelog natively indexes BigQuery, GCS and Pub/Sub in the organisation.
    * Write a shell script to loop through the projects and search the tables using the `bq` CLI - no, this is more effort and slow
