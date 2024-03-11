## GCE instance DNS resolution
By default:
1. On Linux, the VM's metadata server (`169.254.169.254`) resolves internal DNS names
1. On Windows, the subnet's default gateway resolves internal DNS names

## Private/public zones
Private zones are used to provide a namespace that is only visible inside the VPC/hybrid network
Public zones are used to provide authoritative DNS resolution to clients on the public internet

## Policies
Cloud DNS policies define how your organisation uses DNS.
There are three types of policies
### Server policies
These apply private DNS configuration to a VPC network.
Use server polciies to set up hybrid deployments for DNS resolution:
1. Set up an inbound server policy for on-prem workloads to resolve names on GCP
1. Set up an outbound server policy for GCP workloads to use an on-prem DNS resolver
You can configure one DNS server policy for each VPC network - this policy can specific inbound DNS forwarding, outbound DNS forwarding, or both.
#### Caveats
1. DNS server policies are not available for legacy networks
1. DNS server policies require VPC netowkrs
### Response policies
A response policy is a Cloud DNS private zone concept that contains rules instead of records.
These let you modify the behaviour of the DNS resolver by using rules you define.
For example, you can use response policies to create a DNS firewall by returning modified DNS results to clients.
If a rule in the response policy affects the incoming query, it's processed, otherwise the lookup proceeds normally.
#### RPZ
A response policy is different from a _response policy zone_.
An RPZ is an otherwise normal DNS zone with specially formatted data that causes compatible resolvers to do special things.
### Routing policies
These steer traffic based on geolocation or weighted round-robin.
#### Weighted round robin
This lets you specify different weights per DNS target, and Cloud DNS ensures your traffic is distributed accordingly.
This is useful for:
1. Supporting manual active-active or active-passive configs
1. Splitting traffic between production and experimental versions of software
#### Geolocation routing
Lets you map traffic originating from GCP regions to specific DNS targets.
You can use this feature with:
1. The internet
1. External traffic
1. Traffic originating within GCP and bound for internal load balancers
The source geography used is where the query enters Google Cloud.
##### Caveats
Only one type of routing policy can be applied to a `ResourceRecordSet` at a time.
Nesting/combining routing policies is not supported.
