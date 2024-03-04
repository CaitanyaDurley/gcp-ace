# Routes
By default, every network has routes that:
1. Let instances in a network send traffic directly to each other (even across subnets)
1. Direct packets to destinations outside the network
If needed, you can create special routes that overwrite these defaults.
Routes match packets by destination IP address.
When you create a subnet, a route is automatically connected - otherwise VMs on the same network couldn't communicate.

## Routing table
Each route in the _routes collection_ may apply to one or more instances.
A route applies to an instance if the network and isntance tags match.
If the network matches and there are no instance tags specified, the route applies to all instances in that network.
GCE uses the Routes collection to create individual read-only routing tables for each instance.
### Virtual router
At the core of each netowrk is a massively scalable virtual router.
Each VM instance in the network is directly connected to the router.
All packets leaving a VM are first handled at htis layer before being forwarded to their next hop.
The router selects the next hop by consulting the routing table for that instance.


# Firewall rules
Just creating a route does not ensure your packet will be received - firewall rules must allow the packet through.
The default network has firewall rules that allow all instances in the network to talk with each other.
Every VPC network functions as a distributed firewall.
Firewall rules are defined by:
1. The direction (i.e. ingress or egress)
1. The source/destination for ingress/egress resp.
1. The protocol and port
1. The action (i.e. allow or deny)
1. The priority of the rule
The first matching rule is applied

## Stateful rules
GCP firewall rules are stateful. This means that if a connection is allowed between a source and target, then all subsequent traffic in _either direction_ will be allowed.
I.e., once a session is established, bidrectional communication is allowed.

## Implied rules
Even if all firewall rules are delted, there are the following implied rules:
1. Deny all ingress
1. Allow all egress

## Rule assignment
By default all rules are assigned to all instances, however you can assign certian rules to certain instances only.
