# Internal TCP/UDP load balancers
Internal TCP/UDP LBs don't have the overhead of other Cloud LBs, which makes them fast.
Connections are routed directly from clients to the healthy backend with minimal processing.
Responses from the healthy backend go directly to the client, not back through the LB.
TCP responses use _direct server return_.

## Use cases
1. Load balance traffic across multiple VMs functioning as gateway or router VMs
1. Use gateway virtual appliances as the next hop for a default route - i.e. instances in your network send traffic to the internet through a set of load balanced virtual gateway VMs
1. Send traffic through multiple load balancers in 2+ directions by using the same set of multi-NIC gateway/router VMs as backends. Use a load balancer as the next hop for a custom static route in each VPC network. Each internal TCP/UDP load balancer operates within a single VPC network, distributing traffic to the NICs of backend VMs in that network

## Next hop
To specify the next hop there are two options:
1. Forwarding rule name and the load balancer region - next hop load balancer and route must be in the same VPC network
1. Internal IP address of the forwarding rule - next hop load balancer can be in the same network as the route or in a peered VPC network

## Example topologies
### NAT gateway
We LB traffic from internal VMs to multiple NAT gateway instances that in turn route traffic to the internet.
The LB has next hops configured to sever GCE instances.
Each instance has a NAT gateway that runs on it, and has `can_ip_forward` set to true.
### Hub and spoke
Recall that in VPC network peering you can:
1. Exchange subnet routes
1. Export and import custom static & dynamic routes
Custom static routes that have a next hop of the default internet gateway are excluded.
Custom static routes that use next-hop internal TCP/UDP are included.
To add next-hop firewall virtual appliances to your hub VPC network:
1. In the hub network, create an internal TCP/UDP LB with firewall virtual appliances as the backends
1. In the hub network, create a custom static route and set the next hop to be the LB
1. Use VPC network peering to connect the hub network to each of the spoke networks
1. For each peering, have the hub export its custom routes and the spoke import them
1. The next hop firewall appliance LB in the hub is now available in the spoke networks
    * If global access is enabled, the firewall appliance is available according to the routing order
    * If global access is disabled, the resources are only available to requestors in the same region
### Load balancing to multiple NICs
Consider the following example:
1. Have multiple VMs, each with 2 NICs - one for each of two VPC networks (with a subnet in a given region)
1. A LB in one network distibutes traffic from clients to `nic0` (in its network)
1. A LB in the other network distributes traffic from clients to `nic1` (in its network)
This means clients ccan connect to the backend services through either NIC.

## Benefits
When the LB is a next hop for a static route:
1. No special config is needed within the guest OS of the client VMs in the VPC network where the route is defined
1. Client VMs send packets to the LB backends through VPC network routing, in a _bump-in-the-wire_ fashion
1. We get all the same benefits as Internal TCP/UDP Load Balancing

## Caveats
1. Must enable global access on the VPC network so that ne next hop is usable from all regions
1. Even if all health checks fail, the LB next hop is still in effect - if needed configure a failover policy
1. A next hop LB must use an IP unique to a LB forwarding rule
1. Only one backend service is unambiguously referenced
1. Two or more custom static route next hops with the same destination that use different LBs are never distributed by using ECMP
    * If the routes have different priorities, the route with the highest priority is used
    * If the routes have equal priorities, GCP still selects just one LB
1. To route identical source IPs to the same backend, use the `CLIENT_IP_NO_DESTINATION` session affinity option
