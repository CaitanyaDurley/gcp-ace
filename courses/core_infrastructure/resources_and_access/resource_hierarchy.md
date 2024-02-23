GCP's resource hierarchy contains four levels, from bottom to top these are:
1. Resources
1. Projects
1. Folders
1. One organisation node

## Resources
These are VMs, Cloud Storage buckets, tables in BigQuery etc.
Resources are owned by a Project.

## Projects
These can be organised into folders (or optionally subfolders).
Projects are the basis for using GCP services, e.g. managing APIs, enabling bililng etc.
A resource belongs to exactly one project.
Projects can have different owners and users because they're billed and managed separately.
A project is identified by:
1. A project ID - globally unique & immutable, assigned by Google
1. A project name - non-unique and mutable, created by users
1. A project number - unique and google assigned, mainly used internally by google

### Resource Manager
This tool is designed to programmatically help manage projects. 
It's an API that can:
1. gather a list of projects associated with an account
1. Create/update/delete projects
1. Recover deleted projects
It can be accessed through the RPC API and the REST API.

## Folders
These exist to assign policies to resources at a choice level of granularity, since the resources in a folder inherit polcieis and perms assigned to that folder.
E.g. you might create a folder for each department in your organisation.
If two projects are administered by the same team, you can put policies into a common folder so they have the same perms. This is better than duplicating the same policies across both projects.

## Orgnisation node
This owns all the folders, projects and resources in your organisation.
The organisation node has some special roles, eg..:
1. An organisation policy admin who can change policies
1. A project creator role, who can create projects

# Policies
Policies can be defined at the project, folder or organisation node levels.
Some GCP services also allow polciies to be applied to individual resources too.

## Inheritance
Policies are inherited downards, so e.g. if you apply a policy to a folder, it will apply to all of the projects within that folder.
