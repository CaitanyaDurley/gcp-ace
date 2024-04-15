# Cloud Interconnect
All forms of _Cloud Interconnect_ provide interal IP access between resources in your on-prem network and in your VPC network.
The main differences are the connection capacity and the requirements.
Cloud VPN's IPsec tunnels require a VPN device on your on-prem network and have a capacity (per tunnel) of:
1. 1.5Gbps for traffic traversing the public internet
1. 3 Gbps for traffic traversing a direct peering link
You can configure multiple tunnels to scale out this capacity.

## Dedicated Interconnect
_Dedicated interconnect_ allows for direct, physical connections to Google.
This allows you to transfer large amounts of data between networks, which can be more cost effective than purchasing additional bandwidth over the public internet.
You must provision a cross connect between your own router and Google's network in a common colocation facility.
To exchange routes, you configure a BGP session over the interconnect between a Cloud Router and your on-prem router.
Capacity of 10 or 100 Gbps per link, with up to 8 links @ 10Gbps or 2 links @ 100Gbps.

## Partner Interconnect
What if your network is not geographically near a supported colocation facility?
_Partner Interconnect_ provides connectivity through a supported service provider.
Once you establish connectivity with a service provider, you can request a Partner Interconnect connection from your service provider.
Then, you establish a BGP session between your Cloud Router and on-prem router to start passing traffic.
Google supports the connection between Google and the service provider.
Capacity of 50Mbps to 50Gbps - depending on the service provider.

## Cross-Cloud Interconnect
Google provisions a dedicated physical high-bandwidth connection between Google's network and that of another Cloud provider.
You can use this to peer your Google VPC with a network in another cloud provider.
1. Identify supported connections where you want Google to place your connections
1. Purchase primary and redundant Cross-Cloud Interconnect ports.
1. Purchase primary and redundant ports from your cloud service provider
Google supports the connection up to where it reaches the network of your other cloud service provider.
Capacity of either 10 or 100 Gbps.

## Which to choose?
Choose Cloud VPN if:
1. You need a low cost solution
1. Have lower bandwidth needs
1. Are experimenting with migrating workloads to GCP
Choose Dedicated/Partner Interconnect if:
1. You need an enterprise-grade connection
1. Have higher throughput needs
Choose Cross-Cloud Interconnect if:
1. You need to connect to another cloud service provider
