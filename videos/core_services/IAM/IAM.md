## Organisation node
Has many roles:
1. Organisation admin - provides a user access to administer all resources in their organisation
1. Project creator role - allows a user to create projects within their organisation
An organisation resource is automatically created when a _G Suite_ or _Cloud Identity_ account creates a Project.
GCP then communicates its availability to the G Suite or Cloud Identity _super admin_(s).
### Super admins
These super admins:
1. Assign the organisation admin role to some users
1. Are the point of contact in case of recovery issues
1. Control the lifecycle of the Workspace or Cloud Identity account and Organisation resource
### Organisation admin
The responsibilities of the organisation admin role are:
1. Define IAM policies
1. Determine the structure of the resource hierarchy
1. Delegate responsibility over components such as Networking, Billing and Resource Hierarchy through IAM roles
An organisation admin does not have permission to perform other actions, such as creating folders.

## Folders
Folders provide an additional grouping mechanism and isolation boundary between projects.
They can be used to model different departments/teams/legal entities within a company.
Administration rights and access to resources can be limited by folder.

## Resource manager roles
The organisation node also has a viewer role, which grants view access to all resources in the organisation
The folder node has multiple roles that mimic the organisational roles, but are only applied to resources within the folder:
1. Admin role - provides full control over folders
1. Creator role - create folders
1. Viewer role - view all resources within the folder
Similarly for projects, there is a:
1. Creator role - create new projects (the user automatically becomes the owner of the new project)
1. Deleter role - grants deletion privileges for projects
