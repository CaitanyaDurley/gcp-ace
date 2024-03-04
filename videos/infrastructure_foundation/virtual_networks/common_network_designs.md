# Availability
If your application needs increased availability, you can use a regional managed instance group.
Place two VMs into different zones but within the same region & subnet.
Using a single subnet allows you to create a firewall rule against the subnet - so no additional security complexity.

# Globalisation
Putting resources in different regions provides an even higher degree of failure independence.
Using a global load balancer, like the HTTP load balancer, you can route traffic to the region closest to the user.
This means:
1. Lower latency fo rusers
1. Lower egress costs for your project

# Cloud NAT
As a security best practice, VMs should only be assigned internal IPs whenever possible.
_Cloud NAT_ is a managed network address translation service.
It lets your instances access the internet without a public IP.
This is technically called _outbound NAT_, however, cloud NAT does not implement Inbound NAT.
I.e., hosts outside the VPC network cannot access private instances behind the cloud NAT gateway.
## Private google access
Private Google access allows VM instances to reach the external IP addresses of Google API and services, e.g. a GCS bucket.
This is enabled on a subnet basis.
