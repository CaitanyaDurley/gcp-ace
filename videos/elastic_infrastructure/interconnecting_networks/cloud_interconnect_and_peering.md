# Cloud Interconnect & Peering services
There are different Cloud interconnect and Peering services available to connect your infrastructure to Google's network:
These can be split into dedicated vs shared connections and layer 2 vs layer 3 connections.
| Service | Dedicated/Shared | Layer 2/3 |
| ------- | ---------------- | --------- |
| Direct Peering | Dedicated | Layer 3 |
| Carrier Peering | Shared | Layer 3 |
| Dedicated Interconnect | Dedicated | Layer 2 |
| Partner Interconnect | Shared | Both supported |

## Dedicated vs shared
1. Dedicated connections provide a direct connection to Google's network
1. Shared connections provide a connection to Google through a partner

## Layer 2 vs 3
1. Layer 2 connections use a VLAN that pipes directly into your GCP environment providing connectivity to internal IPs
1. Layer 3 connections provide access to Google Workspace services (e.g. GCP APIs) through public IPs
For Partner Interconnect, choose:
1. L2 if you need BGP peering
1. L3 if you don't

## Cloud VPN
Cloud VPN uses the public internet, but traffic is encrypted and provides connectivity to internal IPs.
### Cloud VPN over Interconnect
If you have already chosen an interconnect option, but want Google to manage traffic encryption, use _Cloud VPN over Interconnect_.
