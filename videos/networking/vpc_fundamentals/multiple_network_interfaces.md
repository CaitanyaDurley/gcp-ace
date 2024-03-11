Recall:
1. No communication by internal IP is alllowed between networks unless you set up VPC peering or VPN
1. Every instance in a VPC network has a default network interface

## Uses
Some situations require multiple interfaces:
1. Configuring an instance as a network appliance for load balancing
1. Apps running in an instance require traffic separation, e.g. data plane traffic vs management plane traffic
You can create and attach multiple NICs to your VMs.
Each NIC must have an internal IP and may optionally have an external IP.

## Caveats
1. You can only configure a NIC when creating an instance
1. On a single instance, each NIC must be attached to a different VPC network
1. Each NIC must belong to a subnet which does not overlap with the subnets of any other NICs
1. The additional VPC networks must exist before creating the instance
1. You cannot delete a NIC without deleting the instance
1. When an internal DNS query is made with the instance's hostname it will resolve to the _primary_ interface: `nic0`. This means if the `nic0` interface belongs to a different VPC network than the instance that issued the internal DNS query, the query will fail.
1. Instances with no greater than 2vCPU can have up to 2 NICs
1. Instances with greater than 2vCPU can have 1 NIC per vCPU upto a max of 8
