# Bring Your Own IP
Customers can assign IP addresses to GCP resources from a public range that they own.
Without this, traffic would have to be routed through their own physical networks.

## Use
Once the IPs are imported, GCP manages them identically to Google-provided IPs, except that they are available only to the customer who brought them.
Idle or in-use IPs incur no charges.

## Scope
The object an IP is assigned to can have:
1. Regional scope - e.g. a VM or the forwarding rule of a network load balancer
1. Global scope - e.g. the forwarding rule of a global external HTTP(S) load balancer

## Exclusions
A BYOIP cannot be assigned to a:
1. Classic VPN gateway
1. GKE node/pod
1. Autoscaling managed instance group (MIG)
Also:
1. BYOIP prefixes cannot overlap with subnet or alias ranges in the VPC
1. The IP addresses must be IPv4

## Overlapping BGP route announcments
BGP is a routing protocol that picks the most efficient route to send a packet.
If Google and another network advertise the same route with matching/mismatched prefix lengths, BGP will not work properly.
You might experience unexpected routing and packet loss.
### Example
You're advertising a `203.0.112.0/20` block and using BGP to route packets.
You could bring a `203.0.112.0/23` block you own to Google using BYOIP.
Because the `/23` block is contained within the `/20` block, BGP route announcements might overlap.
BGP routing practices cause the more specific route to take precedence, i.e. the `/23` block.
If the `/23` route ever stopped being advertised, the `/20` block could be used.
