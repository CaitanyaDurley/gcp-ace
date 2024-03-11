# Shared VPC
Allows you to share a common VPC network across several projects within one organisation.
Shared VPC is also known as _XPN_.
The resources can communicate using internal IP addresses from that network, no need for:
1. Cloud VPN
1. VPC Network Peering

## Host/service projects
When using shared VPC, you must designate a project as a _host project_.
The host project owns the VPC which is to be shared.
Each _service project_ that needs access to the shared VPC will have instances in that shared network.

## IAM
Shared VPC makes use of Cloud IAM roles to delegate administration.
### Organisation admin
The Google Workspace or Cloud Identity super administrators are the first users who can access the organisation, and they assign the organisation admin role to users.
The organisation admin can nominate Shared VPC Admins by granting them:
1. Appropriate project creation and deletion roles
1. The `compute.xpnAdmin` role for the organisation
Typically the Shared VPC Admin is also the project owner for the host project.
### Shared VPC Admin
The shared VPC admin performs various tasks to set up shared VPC:
1. Enabling shared VPC on the host project
1. Attaching service projects
1. Delegating access to subnets to Service Project Admins via the `compute.networkUser` role
### Service Project Admin
In addition to being a _Network User_, the service project admin also maintain ownership over resources defined in their service projects.
The service project admin must have at least the `compute.instanceAdmin` role on the service project.
Typically, the service project admin is the project owner of their service project.
