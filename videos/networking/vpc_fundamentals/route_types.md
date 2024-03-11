# Route
Routes define the paths that network traffic takes from a GCE instance to other desinations.
A route is created when a network/subnet is created to enable traffic delivery from anywhere - without this VMs on the same network wouldn't be able to communicate.

## Destinations
Destinations can be inside your VPC or outside it.
Routes match packets by the destination IP address.

## Firewall
Note that a firewall rule is also mandatory for traffic to flow.

## Network tag
Netowrk tags fine-tune which route is picked:
1. If a route has a network tag, it will apply onl to instances that have the same tag
1. If a route doesn't have a network tag, it will apply to all instances in the network

## Route types
Routes can be one of three types.
### System-generated
These are simple and can be used by default
### Custom
When system-generated routes do not provide the desired granularity, use custom routes.
For example, routing traffic between subnets through a network virtual appliance.
### Peering
Peering routes are used for network peering.
