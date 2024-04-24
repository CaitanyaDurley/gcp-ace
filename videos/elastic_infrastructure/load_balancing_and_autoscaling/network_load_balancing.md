# Network LB
Network load balancing is:
1. Regional - traffic can only be balanced between instances in the same region
1. Non-proxied - traffic is passed through the LB instead of being proxied

## Features
The service uses forwarding rules to balance the load based on incoming IP protocol data like:
1. Address
1. Port
1. Protocol type
You can use this LB to balance:
1. UDP traffic
1. TCP & SSL traffic on ports not supported by the proxy load balancers

## Architecture
The architecture depends on the type of LB:
1. Backend service based network LB
1. Target pool based network LB
### Backend service
New network LBs can be created with a regional backend service and hence inherits all their benefits (non-legacy health checks, TCP/SSL/HTTP/HTTPS, autoscaling with MIGs, connection draining, configurable failover policy).
### Target pool
A target pool resource is now legacy, but defines a group of instances that receive incoming traffic from forwarding rules.
The LB picks an instance from these target pools based on a hash of the source and destination IP and port.
Each project can have upto 50 target pools, each with only one health check.
All instances of a target pool must be in the same region.
