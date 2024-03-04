# Virtual machines
Each VM can have two IPs: one internal and one external

## Internal IP
Assigned via DHCP internally.
Every VM and any service that depends on VMs (e.g. GKE, App Engine) gets an internal IP.
### Internal NDS
When a VM is created, its symbolic name is registered with an internal DNS service that translates it to an internal IP.
The DNS is scoped to the network - it can't translate host names from VMs in a different network.

## External IP
A VM may optionally have an external IP.
The external IP may be assigned from:
1. A pool - making it ephermeral
1. A reserved external IP address - making it static
### Unused static IPs
Reserved static IPs that are not assigned to a resource (e.g. a GCE instance or forwarding rule) are charged at a higher rate than for those in use.
### Bring your own
You can use your own publicly routable IP address prefixes as GCP external IP addresses.
In order to be eligible, you must own and bring a `/24` block or larger
