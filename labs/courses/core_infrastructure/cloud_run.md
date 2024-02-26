## Enable Cloud Run API
```sh
gcloud services enable run.googleapis.com
# Set the compute region
gcloud config set compute/region "REGION"
```

## Build container image and push to Artifact Registry
```sh
# Can build image using Cloud Build
gcloud builds submit --tag gcr.io/$GOOGLE_CLOUD_PROJECT/helloworld
# Check image is in artifact registry
gcloud container images list
# Register gcloud as the credential helper for Google-supported Docker registries
# Necessary so Docker can pull the image from Artifact Registry
gcloud auth configure-docker
# Run locally for testing
docker run -d -p 8080:8080 gcr.io/$GOOGLE_CLOUD_PROJECT/helloworld
```

## Deploy to Cloud Run
allow-unauthenticated flag allows HTTP access
```sh
gcloud run deploy --image gcr.io/$GOOGLE_CLOUD_PROJECT/helloworld --allow-unauthenticated --region "REGION"
# It will prompt for the name of the Cloud Run service - hit enter to default to same as image name
```

## Cleanup
```sh
# Delete the container image to avoid charges
gcloud container images delete gcr.io/$GOOGLE_CLOUD_PROJECT/helloworld
# Delete the Cloud Run service
gcloud run services delete helloworld --region "REGION"
```
