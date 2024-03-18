# Service accounts
You can program an application to get credentials (e.g. for accessing GCS) from a service account to seamlessly authenticate with google APIs.
Service accounts are identified by an email address.
There are three types of service accounts:
1. User-created aka custom
1. Built in, i.e.
    * Compute Engine default service account - provided in a project by default
    * App Engine default service accoun
1. Google APIs service account - runs internal google processes on your behalf
The APIs service account has the email `project-number@cloudservices.gserviceaccount.com` and is automatically granted the Editor role on the project.

## Custom service accounts
You can create as many service accounts as you need and assign any access scopes or IAM roles to them.
You can then start an instance with a custom service account.

## Default compute engine service account
Automatically created per project with an auto-generated name and email address: `project_number-compute@developer.gserviceaccount.com`.
Automatically added as a project Editor.
By default, enabled on all instances created using gcloud or the GCP console - you can override this behaviour by specifying another service account or disabling service accounts for the instance.

## Access scopes
Access scopes affect what an instance is authorised to do.
If an application is authenticated (i.e. it has a service account) then it can request access from the _Google Authorisation Server_ and receives an access token.
The access scope for each API (e.g. read-only access to GCS) can be configured when the instance is created.
The google authorisation server will then ensure the access token only grants the access in scope.

Access scopes are the legacy method of specifying permissions to service accounts
For user-created service accounts, use IAM roles to specify permissions instead.

## Roles for service accounts
You can grant the _Service Account User_ role to users for a service account, to let the user access all the resources that the service account has access to.

## Authentication
There are two types of service account keys
### Google-managed service accounts
1. All service accounts have google-managed keys
1. Google stores both the public and private parts of the key
1. Each public key can be used for signing for a maximum of 2 weeks
1. Private keys are held in escrow and are never directly accessible
### User-managed service accounts
1. Google only stores the public portion of a user-managed key
1. Users are reponsible for the security of their private key and for key rotation
1. You can create up to 10 service account keys per service account to facilitate key rotation
1. User managed keys can be managed using the IAM API, gcloud or the Service Accounts page in the console
Caveats:
1. If you lose you user-managed keys, google cannot help you recover them
1. User-managed keys should be used as a last resort
There are alternatives such as short-lived service account credentials (tokens) or service account impersonation