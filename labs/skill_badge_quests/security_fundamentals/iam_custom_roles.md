## View permissions and roles
```sh
# View all permissions available for your project
gcloud iam list-testable-permissions //cloudresourcemanager.googleapis.com/projects/$DEVSHELL_PROJECT_ID
# View role metadata - role ID and permissions contained therein
gcloud iam roles describe roles/viewer
# View grantable roles on a specific resource - here on our project
gcloud iam list-grantable-roles //cloudresourcemanager.googleapis.com/projects/$DEVSHELL_PROJECT_ID
```

## Create a custom role
To create a custom role, the caller needs the `iam.roles.create` permission.
You can use the `gcloud iam roles create` command to create a new custom role:
1. With a yaml file containing the role definition
1. By specifying the role definition using flags
You must specify whether the role applies to the organisation or project level with either the `--organization [ORGANIZATION_ID]` or `--project [PROJECT_ID]` flags.
Example yaml file:
```yaml
title: "Role Editor"
description: "Edit access for App Versions"
stage: "ALPHA"
includedPermissions:
- appengine.versions.create
- appengine.versions.delete
```
```sh
# Create editor role from the yaml
gcloud iam roles create editor --project $DEVSHELL_PROJECT_ID --file role-definition.yaml
# Create viewer role using flags
gcloud iam roles create viewer --project $DEVSHELL_PROJECT_ID \
--title "Role Viewer" --description "Custom role description." \
--permissions compute.instances.get,compute.instances.list --stage ALPHA
```

## Updating custom roles
```sh
# List project-level custom roles
gcloud iam roles list --project $DEVSHELL_PROJECT_ID # use --show-deleted to show deleted roles
# List predefined roles
gcloud iam roles list
```
To update a role with a new yaml file, you must pass the role's current etag, so that Google can be sure you are making amendments to the latest version of the role.
```sh
# Describe the role, including the current etag
gcloud iam roles describe editor --project $DEVSHELL_PROJECT_ID > new-role-definition.yaml
# Modify the yaml file as necessary (but leave the etag)
gcloud iam roles update editor --project $DEVSHELL_PROJECT_ID --file new-role-definition.yaml
# Modify with flags - no etag necessary
gcloud iam roles update viewer --project $DEVSHELL_PROJECT_ID \
--add-permissions storage.buckets.get,storage.buckets.list
```

## Disable/delete custom roles
When a role is disabled, any policy bindings related to the role are inactivated, so the role's permissions will not be granted.
```sh
# Disable the role
gcloud iam roles update viewer --project $DEVSHELL_PROJECT_ID --stage DISABLED
# Delete the role
gcloud iam roles delete viewer --project $DEVSHELL_PROJECT_ID
```
After the role has been deleted, existing bindings remain, but are inactive. The role can be undeleted within 7 days. After 7 days, the role enters a permanent deletion process that lasts 30 days. After 37 days, the Role ID is available to be used again.
```sh
# restore a role deleted in the last 7 days
gcloud iam roles undelete viewer --project $DEVSHELL_PROJECT_ID
```
