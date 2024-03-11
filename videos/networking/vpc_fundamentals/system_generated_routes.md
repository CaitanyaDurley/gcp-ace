# System-generated routes
Created by default when:
1. Creating a VPC network - IPv4 default route `0.0.0.0/0`
1. Creating a dual-stack subnet with an external IPv6 address range - IPv6 default route `::/0`
Both of these serve to define a path out of the VPC network to external IP addresses on the internet.

## Priority
The default route is only used if a route with a more specific destination does not apply to a packet.
To isolate your network from the internet you can delete the default route.
IP ranges not covered by a route will be dropped.
As with firewall rules, lower priority numbers indicate higher priority.

## Custom routes
For IPv4 _only_, to route internet traffic toa  different next hop the default route may be replaced with:
1. A custom static route - e.g. a proxy VM
1. A custom dynamic route

## Subnets
Subnet rotues apply to the subnet only.
They always have the most specific destination and cannot be overridden by higher priority routes.
Each subnet has at least one subnet route whose destination matches the primary IP range of the subnet.
If the subent has secondary IP ranges, each one has a corresponding subnet route.
