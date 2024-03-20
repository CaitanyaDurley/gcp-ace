# Cloud Storage
Create a GCS bucket without public access prevention and with fine-grained (i.e. object-level) access control.
Create three random files: setup.html, setup2.html and setup3.html.

## ACLs
```sh
# Copy the first file to the bucket
gcloud storage cp setup.html gs://$BUCKET_NAME_1
# Get the default ACL assigned to the object
gsutil acl get gs://$BUCKET_NAME_1/setup.html
# Set the ACL to private
gsutil acl set private gs://$BUCKET_NAME_1/setup.html
# Make the file publically readable
gsutil acl ch -u allUsers:R gs://$BUCKET_NAME_1/setup.html
```

## Customer-supplied encryption keys
We need an AES-256 base-64 key
```python
import base64
import os
print(base64.encodebytes(os.urandom(32)))
```
Encryption controls are contained in a gsutil config file named `.boto`
```sh
cat .boto
# If the file is empty, create a new one with
gsutil config -n
# If it's still empty, it might live somewhere else, locate it with
gsutil version -l
```
Uncomment the line `encryption_key=` and paste in our key
Copy the remaining files and verify in the Cloud Console they are customer-encrypted
## Rotate CSEK keys
Uncomment the `decryption_key1=` line and add the previous key.
Generate a new key and replace the entry in `encryption_key=`.
When we _rewrite_ a file, we decrypt it using `decryption_key1` and encrypt it again with the new `encryption_key`.
```sh
gsutil rewrite -k gs://$BUCKET_NAME/setup2.html
```

# Enable lifecycle management
Example JSON lifecycle policy file that deletes objects after 31 days:
```json
{
  "rule":
  [
    {
      "action": {"type": "Delete"},
      "condition": {"age": 31}
    }
  ]
}
```
```sh
# View the current lifecycle policy - should be empty for now
gsutil lifecycle get gs://$BUCKET_NAME_1
# Set the lifecycle policy
gsutil lifecycle set life.json gs://$BUCKET_NAME_1
```

# Enable versioning
```sh
# View current versioning status - the suspended policy means unavailable
gsutil versioning get gs://$BUCKET_NAME_1
# Enable versioning
gsutil versioning set on gs://$BUCKET_NAME_1
# Delete some lines from the file
# Copy the file with the -v versioning option
gcloud storage cp -v setup.html gs://$BUCKET_NAME_1
# List all versions
gcloud storage ls -a gs://$BUCKET_NAME_1/setup.html
# Copy the oldest version of the file
export VERSION_NAME=gs://BUCKET_NAME_1/setup.html#1584457872853517
# Recover the older version
gcloud storage cp $VERSION_NAME recovered.txt
```

# Sync a directory to a bucket
```sh
gsutil rsync -r dirtree gs://$BUCKET_NAME/dirtree
```
