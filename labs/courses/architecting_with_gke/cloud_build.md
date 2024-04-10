# Working with Cloud Build
We investigate building container images with:
1. A dockerfile
1. A build configuration file

## Setup
Create a shell script `quickstart.sh` to represent an application
```sh
#!/bin/sh
echo "Hello, world! The time is $(date)."
```
and remember to make it executable.

## Dockerfile
Create a basic Dockerfile
```Dockerfile
FROM alpine
COPY quickstart.sh /
CMD ["/quickstart.sh"]
```
Now for the build
```sh
# Create a new Docker repository (within Artifact Registry) called quickstart-docker-repo
gcloud artifacts repositories create quickstart-docker-repo --repository-format=docker \
    --location=us-east4 --description="Docker repository"
# Submit the build to Cloud Build by pointing it to the Docker repository
gcloud builds submit --tag us-east4-docker.pkg.dev/${DEVSHELL_PROJECT_ID}/quickstart-docker-repo/quickstart-image:tag1
```
When the build completes you can find the image in the quickstart-docker-repo repository in Artifact Registry.

## Build configuration file
Here we incoporate an existing Docker container using a custom YAML build file
```yaml
steps:
- name: 'gcr.io/cloud-builders/docker'
  args: [ 'build', '-t', 'us-east4-docker.pkg.dev/$PROJECT_ID/quickstart-docker-repo/quickstart-image:tag1', '.' ]
images:
- 'us-east4-docker.pkg.dev/$PROJECT_ID/quickstart-docker-repo/quickstart-image:tag1'
```
This instructs Cloud Build to:
1. Build an image based on the Dockerfile in quickstart-docker-repo
1. Tag it with `quickstart-image`
1. Push the image to Artifact Registry
```sh
# Submit a build using the config
gcloud builds submit --config cloudbuild.yaml
```

## Testing containers in Cloud Build
Replace the contents of quickstart.sh with:
```sh
#!/bin/sh
if [ -z "$1" ]
then
	echo "Hello, world! The time is $(date)."
	exit 0
else
	exit 1
fi
```
Create a cloudbuild2.yaml file with
```yaml
steps:
- name: 'gcr.io/cloud-builders/docker'
  args: [ 'build', '-t', 'us-east4-docker.pkg.dev/$PROJECT_ID/quickstart-docker-repo/quickstart-image:tag1', '.' ]
- name: 'us-east4-docker.pkg.dev/$PROJECT_ID/quickstart-docker-repo/quickstart-image:tag1'
  args: ['fail']
images:
- 'us-east4-docker.pkg.dev/$PROJECT_ID/quickstart-docker-repo/quickstart-image:tag1'
```
This build config runs the quickstart-image it has created.
Upon submitting the build we will receive a build step failure (with a non-zero exit code).
