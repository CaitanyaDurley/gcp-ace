External IPs are unknown to the OS of the VM.
The external IP is mapped to the VM's internal address transparently by the VPC.

# DNS resolution
## Internal addresses
GCP has two types of internal DNS names:
1. Zonal - strongly recommended
1. Global (project wide)
Zonal DNS offers higher reliability guarantees by isolating failures in the NDS registration to individual zones.
The hostname of an instance is the same as the instance name, and can be resolved to its internal IP.
An instance also has an internal FQDN.
Deleting and recreating an instance can cause the internal IP to change - but the DNS name always points to a specific instance.
Each instance has a metadata server that also acts as a DNS resolver for that instance.
The metadata server handles all DNS queries for local network resources and routes all other queries to Google's public DNS servers.

## External addresses
The network stores a lookup table that matches external IP addresses with the internal IP of the relevant instnaces.
Public NDS records pointing to isntances are not published automatically, though admins can publish these using:
1. Existing DNS servers
1. Cloud NDS

# Cloud DNS
Cloud DNS is a scalable, reliable and managed authoritative DNS service.
It uses Google's global netowrk of _Anycast_ name servers to serve DNS zones from redundant locations around hte world.
Domains configured in Cloud DNS have a 100% uptime SLA.

# Alias IP ranges
Alias IP ranges let you assign a range of internal IPs as an alias to the VM's network interface.
This is useful if you have multiple services running on a VM, and you want each to have a different IP.
Alias IP ranges can be drawn from the local subnet's primary or secondary CIDR ranges.
