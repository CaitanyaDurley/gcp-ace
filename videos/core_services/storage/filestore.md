# Filestore
Filestore is a managed file storage service for apps that require:
1. A file system interface
1. A shared file system for data

## Benefits
1. Fully managed NAS with GCE or GKE instances.
1. Predictably fast scale-out performance
1. Native compatibility with existing enterprise apps
1. Supports any NFSV3 compatible clients
1. Hundreds of TB of capacity
1. File locking without specialised plugins or client-side software
1. Low latency fore file operations

## Use cases
1. Migrate on-prem apps that require a shared file system interface to the cloud
1. Media rendering - you can mount a file share across fleets of GCE instances
1. Electronic design automation (EDA) - ensure files are universally accessible to batch workloads
1. Data analytics workloads, e.g. financial models - these are latency sensitive tasks, and Filestore avoids having to offload data to clients drives
1. Hosting providers, e.g. wordpress hosting - to manage and serve web content
