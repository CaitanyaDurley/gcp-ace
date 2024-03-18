## Members
There are five types of IAM members

### Google accounts
A google account of course identifies a person.
Any email address associated with a Google account can be an identity including domains other than `gmail.com`.

### Service account
Belongs to your application rather than an individual.
When you run code that is hosted on GCP, you specify the account that code should run as.

### Google group
A named collection of Google accounts and service accounts.
Every group has a unique email address associated with it.
They provide a convnient way to apply an access policy to a collection of users.

### Workspace domain
Represents a virtual group of all the google accounts that have been created in an organisation's workspace account.
A workspace domain is tied to your internet domain name, e.g. `example.com`, and when you add a user to your workspace domain, a new google account is created for the user inside this virtual group, e.g. `username@example.com`

### Cloud Identity domain
GCP customers who are not Workspace customers can get these same capabilities through Cloud Identity.
You can manage users and groups using the Google Admin console, but you do not pay for and canot use Workspace products such as Gmail, Drive etc.

## Managing users/groups
You cannot manage users or groups with IAM.
Instead, you use Cloud Identity or Workspace to do this.

## Policies
1. A policy consists of a list of bindings.
1. A binding binds a list of members to a role
1. A role is a named list of permissions defined in IAM
Note that resources inherit policies from their parent and that a less restrictive parent policy will always override a more restrictive resource policy.
Also note that changing the resource hierarchy will automatically change the policy hierarchy, e.g. if you move a project into a different organisation then the project's IAM policy will automatically be updated to inherit from the new organisation's IAM policy.
### Allow policies
An allow policy grants access to the resource to which it is attached (and descendents), e.g.
```json
{
    "bindings": [
        {
            "members": [
                "user:jie@example.com",
                "user:raha@example.com"
            ],
            "role": "roles/resourcemanager.projectCreator"
        }
    ]
}
```
### Deny policies
1. Are made up of deny rules
1. Each deny rule specifies a set of principals and the permissions they are denied access to
1. A deny rule may optionally have a condition that must hold for the permission to be denied
1. When a principal is denied permission, they cannot use it regardless of any IAM roles they are granted
1. This is because IAM always checks deny policies before allow policies

## IAM Conditions
These enforce conditional, attribute-based access control for GCP resources.
For example, you could configure temporary access for users in the event of a PROD issue.
They are specified in the role bindings of a resource's IAM policy.

## Organisation policies
This is a constraint configured with the desired restrictions for the organisation.
Resources in the organisation can only be granted an exception by a user who has the _organisation policy admin_ role.

## Directory sync
Let's your administators log in and manage GCP resources using the same username and passwords they already use.
It synchronises users and groups from your existing Active Directory or LDAP system with the users and groups in your Cloud Identity domain.
The sync is one way, so no info in your active directory or LDAP map is modified.
Directory sync is designed to run scheduled syncs without supervision once its rules are set up.

## SSO
If you have an identity system set up, you can continue to use it with SSO.
When authentication is required, Google will redirect to your system.
This also allows you to revoke access to GCP.