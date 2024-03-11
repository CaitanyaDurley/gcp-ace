# Policy constraints
These let you centrally manage access to GCP resources, including VPC networks.
IAM focuses on _who_, by giving them permissions.
Organisation policy focuses on _what_, by setting restrictions on resources.

## Organisation policy
The _Organisation Policy Service_ gives the organisation policy administrator centralised and programmatic control over the organisation's cloud resources.
You can configure constraints across the resource hierarchy.
An organisation policy is just a configuration of restrictions.
You can then set that policy on:
1. The organisation
1. Folders
1. Projects
Descendants of the targeted resource inherit the organisation policy.
### Constraints
To define an organisation policy, you choose a constraint, which is a type of restriction against a (group of) GCP service(s).
You can configure the constraint with your desired restrictions.

## Examples
1. Skip default network creation
1. Disable all IPv6 usage
