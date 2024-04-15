# Cloud VPN
_Cloud VPN_ securely connects your on-prem network to your GCP VPC network.
There are two types of Cloud VPN gateways - Classic VPN and HA VPN.

## Classic VPN
All cloud VPN gateways created before the introduction of HA VPN are Classic VPN gateways.
1. Classic VPN uses an IPsec VPN tunnel.
1. Traffic is encrypted at the outbound gateway and decrypted by the other VPN gateway.
1. Your data is protected as it travels over the public internet.
1. Useful for low-volume data connections
1. SLA of 99.9%
1. Supports:
    * Site-to-site VPN
    * Static & dynamic routes - dynamic routes are configured with Cloud Router
    * IKEv1 & IKEv2 ciphers
1. Does not support client computers "dialling in" using client VPN software
### Gateways
The Cloud VPN gateway is a *regional* resource with a regional external IP.
The on-prem VPN gateway can be:
1. A physical device in your data center
1. A software-based VPN in another cloud provider's network
But it must also have an external IP.
### VPN tunnels
A VPN tunnel connects your gateways as a virtual medium for traffic.
You must establish two VPN tunnels - each defines the connection from the perspective of its gateway - so traffic can only pass when both tunnels are established.
The _maximum transmission unit_, or MTU, of your on-prem gateway cannot exceed 1460 bytes due to encryption and encapsulation of packets.

## HA VPN
1. _HA VPN_ utilises an IPsec VPN connection in a single region.
1. SLA of 99.99%
To guarantee this SLA, you must configure 2 or 4 tunnels from your HA VPN gateway to your peer VPN gateway.
### Gateways
When you create a HA VPN gateway, GCP automatically chooses two external IP addresses - one for each of its two interfaces.
Each of the gateway interfaces supports multiple tunnels.
You can configure a HA VPN gateway with one interface and external IP, however the SLA will not apply.
There are three typical peer gateway configurations:
1. Two separate peer VPN devices, each with its own IP
1. One peer VPN device with two separate IPs
1. One peer VPN device with one IP
### Tunnels
VPN tunnels conected to HA VPN gateways must use dynamic (BGP) routing.
Depending on the way you configure route priorities, you can create an active/active or active/passive routing configuration.
Supports site-to-site VPN for the following topologies:
1. HA VPN gateway to peer VPN devices
1. HA VPN gateway to an AWS virtual private gateway
1. Two HA VPN gateways connected to each other
### AWS
When configuring a HA VPN external VPN gateway to AWS you can use:
1. A transit gateway - only this one suppoorts ECMP
1. A virtual private gateway
ECMP, or _equal-cost multipath_ routing, equally distrinutes traffic across active tunnels.

## Interconnecting networks
You can connect two VPC networks together using an HA VPN gateway in each network.
Each gateway creates two tunnels:
1. From interface 0 on one gateway to interface 0 on the other gateway
1. From interface 1 on one gateway to interface 1 on the other gateway

## Cloud router
To use dynamic routes, you must configure Cloud Router.
This allows routes to be updated & exchanged without changing the tunnel configuration.
Cloud Router can manage routes for a Cloud VPN tunnel:
1. Cloud Router established a BGP session between the VPC and the on-prem VPN gateway
    * The on-prem VPN gateway must support BGP
    * An additional IP must be assigned to each end of the tunnel
    * These two IPs must be link-local IPs in the range `169.254.0.0/16`
1. E.g. new subnets are seamlessly advertised between networks
