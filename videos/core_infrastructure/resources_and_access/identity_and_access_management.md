# IAM
When an organisation node contains lots of dolder, projects and resources, it may be necessary to restrict who has access to what.
IAM lets administrators apply policies that define who can do what on which resources.

## Principal
The "who" part of an IAM policy is referred to as a _principal_ and can be a:
1. Google account
1. Google group
1. Service account
1. Cloud Identity domain
Each principal has its own identifier, usually an email address.

## Role
The "can do what" part of an IAM policy is defined by a role - a collection of permissions.
When you grant a role to a principal, the principal is granted all the permissions that the role contains.

### Resource hierarchy
When a principal is given a role on a specific element of the resource hierarchy, the policy applies to both the chosen element and all its children.
You can define deny rules that prevent certain principals from using certain permissions, regardless of the roles they're granted.
This works because IAM checks deny policies before allow policies.
Like allow policies, deny policies are inherited down the hierarchy.

### IAM role types
There are three kind of roles in IAM: basic, predefined and custom

#### Basic
These are quite broad.
When applied to a GCP project they affect all resources in that project.
Examples:
1. Viewer - can access resources but can't make changes
1. Editors - can access and make changes to a resource
1. Owners - Can also manage the associated roles and perms and set up billing
1. Bliling administrator - Can control the billing for a project, but cannot change the resources

If several people are working together on a project that contains sensitive data, basic roles are likely too broad.

#### Predefined roles
Specific GCP services offer sets of predefined roles, and can define where those roles can be applied.
E.g. for Compute Engine, you can apply the predefined role _instanceAdmin_ to specific GCE resources in a project, folder or organisation.

#### Custom role
If you need to assign a role with even more specific permissions then use a custom role.
These let you define the exact permissions you want.
You'll need to manage the permissions that define the custom role you've created.
Custom roles can only be applied to the project or organisation level: not folder level.
