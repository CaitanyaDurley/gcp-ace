# Create a GCS bucket using gcloud
```sh
export LOCATION=US
# Bucket name must be globally unique
export BUCKET_NAME=$DEVSHELL_PROJECT_ID
gcloud storage buckets create -l $LOCATION gs://$BUCKET_NAME
```

## Copying to/from a GCS location
```sh
# Copy from a public location to Cloud Shell
gcloud storage cp gs://cloud-training/gcpfci/my-excellent-blog.png .
# Copy from Cloud Shell to our GCS bucket
gcloud storage cp my-excellent-blog.png gs://$BUCKET_NAME
```

## Modify the CAL of an object in GCS
```sh
# Make the image readable by everyone (on the internet)
gsutil acl ch -u allUsers:R gs://$BUCKET_NAME/my-excellent-blog.png
```

# Create a Cloud SQL instance (Console)
Notes:
1. Choose a password for the root user
1. For testing choose Enterprise edition and Sandbox spec
1. Create a (non-root) user account for accessing the DB
1. Must create a "network" (within the Connections menu) to whitelist the IPs in the CIDR range
