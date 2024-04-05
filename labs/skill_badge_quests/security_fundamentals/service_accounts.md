# Service accounts
```sh
# Create a service account
gcloud iam service-accounts create my-sa-123 --display-name "my service account"
# Grant the editor role to the service account
gcloud projects add-iam-policy-binding $DEVSHELL_PROJECT_ID \
    --member serviceAccount:my-sa-123@$DEVSHELL_PROJECT_ID.iam.gserviceaccount.com --role roles/editor
```
