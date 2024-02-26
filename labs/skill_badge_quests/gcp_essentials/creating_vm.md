## Set default region and zone
```sh
gcloud config set compute/region $REGION
gcloud config set compute/zone $ZONE
```

## Create GCE instance with gcloud
```sh
gcloud compute instances create name --machine-type e2-medium
# To SSH
gcloud compute ssh name
```
