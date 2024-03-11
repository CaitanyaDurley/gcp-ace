When a VM is connected to more than one network using multiple NICs, the migration process updates one of the interfaces and leaves the rest in place.
The migrations supported are:
1. From a legacy network to a VPC network in the same project
1. From one VPC network to another VPC network in the same project
1. From one subnet of a VPC network to another subnet of the same network
1. From a service project network to the shared network of a Shared VPC host project
In all cases the VM stays in the zone it was before - only the attached network changes.

## Requirements
1. The VM must be stopped before it can be migrated
1. The VM must not be in an instance group or _network endpoint group_ (NEG)
    * If the VM is in an unmanaged instance group or NEG, you must take it out of the group before migrating it
    * VMs in managed instance groups cannot be migrated - copy your instance yelplate to the new network and use it to rebuild the MIG there
    * You can move instances in target pools (a group of instances that receive traffic from a load balancer) without removing them first - the target pool expands to cover both networks

## Limitations
1. You cannot migrate a VM interface to a legacy network
1. The MAC address of the NIC will change during the migration - this could have an impact on third-party license agreements
1. If you are migrating the VM to a network/subnet with a different IP range, the internal IP will change
    * If you are migrating to a subnet with the same IP range, you can keep the old IP by specifying it during migration
    * You can keep the existing external IP in the new location - so long as the target network has the `compute.subnetworks.useExternalIp` permission and doesn't have the `constraints/compute.vmExternalIpAccess` constraint
