# Create an auto mode network
Console:
1. Create VPC network
1. Name -> mynetwork
1. Subnet creation mode -> automatic
1. Firewall rules -> all available rules (same as default)
1. Create

# Convert to custom mode network
1. Click mynetwork
1. Edit
1. Subnet creation mode -> Custom
1. Save

# Create custom mode network
## Console
We ensure the CIDR ranges don't overlap so we could set up VPC peering between the networks.
1. Name -> managementnet
1. Subnet creation mode -> Custom
1. One subnet:
    * Name -> managementsubnet-us
    * Region -> REGION1
    * IPv4 range -> 10.240.0.0/20
## gcloud
```sh
# Create the network
gcloud compute networks create privatenet --subnet-mode=custom
# Create a privatesubnet-us subnet
gcloud compute networks subnets create privatesubnet-us --network=privatenet --region=$REGION1 --range=172.16.0.0/24
# Create a privatesubnet-eu subnet
gcloud compute networks subnets create privatesubnet-eu --network privatenet --region $REGION2 --range 172.20.0.0/20
# Check
gcloud compute networks list
gcloud compute networks subnets list --sort-by NETWORK
```

# Create firewall rules
## Console
1. Create firewall rule
1. One rule:
    * Name -> managementnet-allow-icmp-ssh-rdp
    * Network -> managementnet
    * Targets -> All instances in the network
    * Source filter -> IPv4 Ranges
    * Source IPv4 ranges -> 0.0.0.0/0
    * Protocols and ports -> Specified protocols and ports
    * tcp -> 22 & 3389
    * Other protocols -> icmp
1. Create
## gcloud
```sh
gcloud compute firewall-rules create privatenet-allow-icmp-ssh-rdp --direction=INGRESS --priority=1000 --network=privatenet \
    --action=ALLOW --rules=icmp,tcp:22,tcp:3389 --source-ranges=0.0.0.0/0
# Check
gcloud compute firewall-rules list --sort-by=NETWORK
```

# Create VMs
## Console
1. Create instance
1. Name -> managementnet-us-vm
1. Region -> REGION1
1. Zone -> ZONE1
1. Advanced -> Networking -> Networking interfaces:
    * Network -> managementnet
    * Subnet -> managementsubnet-us
1. Create
## gcloud
```sh
gcloud compute instances create privatenet-us-vm --zone $ZONE1 --subnet privatesubnet-us
# check
gcloud compute instances list --sort-by=ZONE
```
