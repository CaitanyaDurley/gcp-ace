# IPv6
VPC networks now support IPv6 addresses.
Support can vary per subnet.

## Subnet stack
The _subnet stack_ defines the type of address that can be assigned to objects in the subnet:
1. Single-stack subnets support IPv4 only
1. Dual-stack subnets support IPv4 and IPv6
There's no subnet stack for solely IPv6.

## IPv6 access type
### Internal
Internal IPv6 addresses are used for VM to VM communication within VPC networks.
They use _unique local addresses_ (ULAs) which can only be routed within VPC networks.
### External
External IPv6 addresses are routable on the internet in addition to within VPC networks.
They use _global unicast addresses_ (GUAs).

## Enabling IPv6
### Internal
To enable internal IPv6 on a subnet you must assign an internal IPv6 range on the VPC network.
A `/48` range from within `fd20::/20` is assigned to the network.
All internal IPv6 subnet ranges in the network are assigned from this `/48` range.
The `/48` range may be automatically assigned, or manually selected.
### Reserved ranges
GCP reserves:
1. The `fd20::/20` range for ULA address allocation
1. The `2600:1900::/28` range for GUA address allocation

## VMs
Connected VMs inherit the IPv6 access type from the subnet.
### Configuration
When you enable IPv6 on a VM, the VM is assigned a `/96` _range_ from the subnet it's connected to.
You don't configure whether a VM gets internal or external IPv6 addresses - the VM inherits the IPv6 access type from the subnet.

## Caveats
1. Dual-stack subnets are not supported on auto mode VPC networks
1. Dual-stack subnets are not supported on legacy networks
