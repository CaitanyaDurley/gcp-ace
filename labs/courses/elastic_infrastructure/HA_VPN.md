# HA VPN
In this lab, we create two VPCs (vpc-demo & on-prem) and setup a HA VPN to connect them.

## VPCs
### vpc-demo
```sh
# Create the VPC network
gcloud compute networks create vpc-demo --subnet-mode custom
# Create subnet vpc-demo-subnet1
gcloud compute networks subnets create vpc-demo-subnet1 --network vpc-demo --range 10.1.1.0/24 --region us-central1
# Create subnet vpc-demo-subnet2
gcloud compute networks subnets create vpc-demo-subnet2 --network vpc-demo --range 10.2.1.0/24 --region us-east1
# Create firewall rule to allow all traffic within the network
gcloud compute firewall-rules create vpc-demo-allow-custom --network vpc-demo --source-ranges 10.0.0.0/8 \
    --allow tcp:0-65535,udp:0-65535,icmp
# Create firewall rule to allow SSH, ICMP traffic from anywhere
gcloud compute firewall-rules create vpc-demo-allow-ssh-icmp --network vpc-demo --allow tcp:22,icmp
# Create a VM in us-central1
gcloud compute instances create vpc-demo-instance1 --zone us-central1-a --subnet vpc-demo-subnet1
# Create a VM in us-east1
gcloud compute instances create vpc-demo-instance2 --zone us-east1-a --subnet vpc-demo-subnet2
```
### on-prem
Same as above, but with one subnet in us-central1 and one VM in us-central1-b (i.e. different to the zone of the prevs VM)

## HA VPN
We need to create a HA VPN gateway in each VPC network and tunnels on each gateway.
### Gateway
```sh
# Create a gateway in vpc-demo
gcloud compute vpn-gateways create vpc-demo-vpn-gw1 --network vpc-demo --region us-central1
# Create a gateway in on-prem
gcloud compute vpn-gateways create on-prem-vpn-gw1 --network on-prem --region us-central1
# verify
gcloud compute vpn-gateways describe vpc-demo-vpn-gw1 --region us-central1
# Create a cloud router in vpc-demo
gcloud compute routers create vpc-demo-router1 --region us-central1 --network vpc-demo --asn 65001
# Create a cloud router in on-prem
gcloud compute routers create on-prem-router1 --region us-central1 --network on-prem --asn 65002
```
### Tunnels
We add two tunnels from each gateway - with interface0 of one gateway connecting to interface0 of the other gateway, and the same for interface1.
```sh
# Create the first VPN tunnel in vpc-demo
gcloud compute vpn-tunnels create vpc-demo-tunnel0 \
    --peer-gcp-gateway on-prem-vpn-gw1 \
    --region us-central1 \
    --ike-version 2 \
    --shared-secret [SHARED_SECRET] \
    --router vpc-demo-router1 \
    --vpn-gateway vpc-demo-vpn-gw1
    --interface 0
# Create the second VPN tunnel in vpc-demo
gcloud compute vpn-tunnels create vpc-demo-tunnel1 \
    --peer-gcp-gateway on-prem-vpn-gw1 \
    --region us-central1 \
    --ike-version 2 \
    --shared-secret [SHARED_SECRET] \
    --router vpc-demo-router1 \
    --vpn-gateway vpc-demo-vpn-gw1
    --interface 1
# Do the same for on-prem
```

## BGP
We now configure BGP peering for each VPN tunnel.
```sh
# Create the router interface for tunnel0 in vpc-demo
gcloud compute routers add-interface vpc-demo-router1 \
    --interface-name if-tunnel0-to-on-prem \
    --ip-address 169.254.0.1 \
    --mask-length 30 \
    --vpn-tunnel vpc-demo-tunnel0 \
    --region us-central1
# Create the BGP peer for tunnel0 in vpc-demo
gcloud compute routers add-bgp-peer vpc-demo-router1 \
    --peer-name bgp-on-prem-tunnel0 \
    --interface if-tunnel0-to-on-prem \
    --peer-ip-address 169.254.0.2 \
    --peer-asn 65002 \
    --region us-central1
# Do the same for tunnel1 in vpc-demo, and both tunnels in on-prem
```

## Firewall rules
We need firewall rules to allow traffic from the private IP ranges of the peer VPN
```sh
# Allow traffic from on-prem to vpc-demo
gcloud compute firewall-rules create vpc-demo-allow-subnets-from-on-prem \
    --network vpc-demo \
    --allow tcp,udp,icmp \
    --source-ranges 192.168.1.0/24
# Allow traffic from vpc-demo to on-prem
gcloud compute firewall-rules create on-prem-allow-subnets-from-vpc-demo \
    --network on-prem \
    --allow tcp,udp,icmp \
    --source-ranges 10.1.1.0/24,10.2.1.0/24
```

## Verify
### Private connectivity over VPN
```sh
# SSH into on-prem-instace1
gcloud compute ssh on-prem-instance1 --zone us-central1-a
# Ping instances in vpc-demo
ping 10.1.1.2
```
### Global routing
HA VPN is a regional resource and cloud router by default only sees the routes in the region in which it is deployed.
To reach instances in a different region that the cloud router, you must enable global routing mode for the VPC.
This allows the cloud router to see and advertise routes from other regions.
```sh
# Update the bgp-routing-mode on vpc-demo
gcloud compute networks update vpc-demo --bgp-routing-mode GLOBAL
# From on-prem-instance1: can now reach us-east1 in vpc-demo
ping 10.2.1.2
```
### HA
```sh
# Bring down tunnel0 in vpc-demo
gcloud compute vpn-tunnels delete vpc-demo-tunnel0 --region us-central1
# From on-prem-instance1
ping 10.1.1.2 # still works
```
