## Routing tables
Much like physical networks, VPCs have routing tables.
These are built-in to the network, so you don't have to provision a router.

## Firewalls
VPCs provide a global distributed firewall which can be controlled to restrict access.
Again, this is built-in so no need to provision one.
Firewall rules can be defined through network tags on GCE instances, e.g. you can tag all web servers with "WEB" and tell the firewall to allow traffic on port 443 to VMs with the "WEB" tag.

## VPC Peering
Recall the VPCs belong to a GCP project. If your organisation has multiple projects, and the VPCs need to talk to each other then you can use VPC Peering.
This allows the two VPCs to exchange traffic.

## Shared VPC
Another alternative is to configure a Shared VPC and use IAM to control what in one project can interact with a VPC in another project.
