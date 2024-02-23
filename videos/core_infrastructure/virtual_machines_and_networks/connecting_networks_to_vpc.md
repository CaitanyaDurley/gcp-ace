Many GCP customers want to connect their VPC networks to networks on-prem or in other clouds.
There are many ways to accomplish this:

## VPN
Start with a VPN connection over the internet and use _Cloud VPN_ to create a tunnel.
To make the connection dynamic, you can use _Cloud Router_
### Cloud router
Lets other networks and Google VPC ecxhange route info over the VPN using the _Border Gateway Protocol_.
This means if you add a new subnet to your google VPC, your on-prem network will automatically get routes to it.

## Peering
Using the internet can cause concerns about security and bandwidth reliability.
Peering means putting a router in the same data center as a Google _point of presence_ and using it to exchange traffic between networks.
### Direct peering
_Direct Peering_ is when you put your router in the aforementioned data center.
### Carrier peering
Customers who aren't already in a point of presence can work with a partner in the _Carrier Peering program_.
_Carrier Peering_ is Peering using a service provider's network to Google Cloud products that can be exposed through public IPs.

## Dedicated Interconnect
Peering isn't covered by a Google SLA.
_Dedicated interconnect_ allows for direct, private connections to Google.
This is achieved via a Dedicated Interconnect colocation facility.
The connection will support 10GB/s.
They are covered by an SLA of up to 99.99%.
These connections can be backed up by a VPN for greater reliability.

## Partner Interconnect
This provides connectivity through a supported service provider.
This is useful if a data center is in a physical location that can't reach a Dedicated Interconnect colocation facility or the data needs don't warrant the 10GB/s connection.
Partner Interconnect can be configured for upto 99.99% SLA, though this only covers the aspects provided by Google, not the third-party.

## Cross-Cloud Interconnect
Google provisions a dedicated physical high-bandwidth connection between Google's network and that of another Cloud provider.
These are available in 10Gbps and 100Gbps
