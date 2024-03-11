# VPC Network Peering
Allows private connectivity across two VPC networks.
You can peer VPCs:
1. Within the same project
1. In different organisations
Each VPC network's firewall rules define what traffic is allowed between the peered networks.

## Peering relationships
So establish Network peering, two peering relationships must be created:
1. The first network's _Network Admin_ must peer with the second network
1. The second network's _Network Admin_ must peer with the first network
After which, the VPC network peering session becomes active and routes are exchanged.

## Decentralised
VPC Network Peering is a decentralised/distributed approach to multi-project networking.
Each VPC network remains in the control of separate admin groups and maintains its own global firewall and routing tables.
It doesn't incur the latency, security and cost drawbacks of using external IPs or VPNs.

## Usage
VPC Network Peering works with:
1. Compute Engine
1. GKE
1. App Engine flexible environments

## Caveats
Each network must be administered separately.
Either side can delete the peering association at any time.
A subnet CIDR prefix in one peered network cannot overlap with a subnet CIDR prefix in another peered network.
E.g. two auto mode VPC networks cannot peer.
VPC peering is not transitive.
You must have the name of the VPC network with which you will peer with (and the project ID if in another project).
