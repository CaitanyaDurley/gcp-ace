## Projects
A network is entirely contained within a project.
The default quota for each project is 15 networks.
Networks can be shared with other projects or peered with networks in other projects.

## IP ranges
Networks do not have IP ranges in and of themselves.
They are simply a construct of all of the individual IP addresses and services within that network.

## Global
Networks are global, spanning all regions.
Subnetworks are regional, spanning all zones within the region.

## Types of network
There are three types of network:
1. Default
1. Auto
1. Custom
### Default
Each project is provided with a default VPC network with preset subnets and firewall rules.
A subnet is allocated for each region with:
1. non-overlapping CIDR ranges
1. Firewall rules that allow ingress for ICMP/RDP/SSH traffic from anywhere
1. Firewall rules that allow ingress on any protocol/port from within the default network
### Auto
One subnet from each region is automatically created within it.
Note the default network is an auto mode network.
Each subnet has a `/20` mask which may be expanded to `/16`.
All of the subnets lie within the `10.128.0.0/9` CIDR block.
As new GCP regions become available, new subnets in those regions are automatically added to auto mode netowrks.
### Custom
Does not automatically create subnets.
You have complete control over subnets and IP ranges.
Subnet IP ranges may not overlap.
You can convert an auto mode network to a custom mode, but not vice versa.
Custom mode networks support IPv6 - e.g. you can configure IPv6 addressing on _dual-stack_ VM instances running both IPv4 and IPv6.

## Cross-network communication
VMs on the same network can communicate with internal IP addresses, regardless of their geographical location.
VMs on different networks must communicate with their external IP addresses.
If the VMs are in the same region, the traffic won't touch the public internet, but go through the _Google Edge_ routers. This has different billing and security ramifications.

## Reserved IPs
Within a subnet, the following addresses are reserved:
1. The first address (usually `.0`) for the network
1. The second address (usually `.1`) for the subnet's gateway
1. The last two addresses (usually `.254` and `.255`) for the _broadcast_ address.
Subnets cannot span a valid RFC range and a privately used public IP address range.
Subnet ranges cannot span multiple RFC ranges

## Expanding subnets
Subnets can be expanded with no downtime.
However, you cannot undo an expansion.
Avoid creating large subnets since these are more likely to cause CIDR range collisions when:
1. Using multiple network interfaces
1. VPC network peering
1. Configuring a VPN ot other connections to aon on-prem network
