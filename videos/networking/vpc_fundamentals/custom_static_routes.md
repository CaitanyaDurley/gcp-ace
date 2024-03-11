# Custom static routes
1. Forward packets to a static route next hop.
1. Useful for small & stable topologies.

## Benefits
Static routes have the following benefits over dynamic routes:
1. Quicker routing performance - as no processing power is devoted to maintaining/modifying the routes
1. More secure - as there is no route advertisement

## Limitations
1. Cannot point to a VLAN attachment
1. Requires more maintenance - as routes are not dynamically updated, e.g. a topology change on either network
1. If a link fails static routes cannot reroute traffic automatically

## VM network controllers
These are kept informed of all routes from the network's routing table.
Changes to routes are propogated to the VM controllers.

