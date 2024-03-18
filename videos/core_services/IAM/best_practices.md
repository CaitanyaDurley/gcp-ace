## Trust boundary
Use projects to group resources that share the same trust boundary.
Use the principle of least privilege.

## Audit
Audit:
1. Policies using Cloud audit logs
1. Membership of groups using policies

## Groups not individuals
Grant roles to groups rather than individuals.
This allows you to update group membership rather than changing a Cloud IAM policy.
You can also use multiple groups to get better control.

## Service accounts
Be very careful granting the service accounts user role.
When creating a service account give it a display name that clearly identifies its purpose.
Establish key rotation policies and methods and audit keys with the `serviceAccount.keys.list` method.

## Cloud IAP
Cloud IAP lets you establish a central authorisation layer for applications accessed by HTTPS.
This means you can use an application level access control model rather than relying on network level firewalls.
Applications and resources protected by Cloud IAP can only be accessed through the proxy by users and groups with the correct Cloud IAM role.
User access to the resource is subject to the fine-grained access controls implemented by the product in use without requiring a VPN.