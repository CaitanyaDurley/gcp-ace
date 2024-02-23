Service accounts let you grant permissions to a GCP service rather than a person.
E.g. A GCE isntance needs to access data in Cloud Storage.
You can create a service account to authenticate that instance to talk to Cloud Storage.

## Auth
Service accounts are named with an email address, but use cryptographic keys instead of passwords to access resources.

## Service accounts are resources
In addition to being an identity, a service account is also a resource, and can have IAM policies of its own attached to it.
E.g. you could have one person with editor role on a service account, and another with just the viewer role.
