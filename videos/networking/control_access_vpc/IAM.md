## Policies
Recall GCP resources are organised hierarchically.
Let's go through each of the levels from top to bottom, since resources inheirt policies from their parent

### Organisation
1. Represents your company
1. IAM roles granted at this level are inherited by all resources under the organisation
### Folder
1. Could represent a department, for example
1. IAM roles granted at this level are inherited by all resources in the folder
### Project
1. Represent a trust boundary within your company
1. Servies within a project have a default level of trust

## Child overrides
A child policy cannot restrict access granted at the parent level.
E.g., if someone grants you the Editor role on a folder, and someone grants you the Viewer role for a project within, you will still have the Editor role for that project.

## Deny/Allow policies
Deny policies take precedence over access policies.
They were introduced to prevent certain principals from using certain permissions, regardless of the roles they're granted.
Each project, folder and organisation can have up to 5 deny polciies attached.

## Predefined roles
Let's look at some predefined roles that provide granular access to VPC networking resources.
### Network Viewer
Provides read-only access to all networking resources.
E.g., if you have software that inspects your network configuration, you could grant that software's service account the Network Viewer role.
### Network Admin
Contains permissions to create, modify and delete networking resources except for:
1. Firewall rules
1. SSL certificates
### Security Admin
Contains permissions to create, modify and delete firewall rules and SSL certs.
