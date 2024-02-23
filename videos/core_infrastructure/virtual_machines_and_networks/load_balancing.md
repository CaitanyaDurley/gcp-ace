A load balancer distributes user traffic across multiple instances of an application.
_Cloud Load Balancing_ is a fully distributed, software-defined, managed service.
You don't have to scale or manage the load balancers.
Supported protocols: HTTP(s), TCP, SSL, UDP
Cross-region load balancing is supported, including automatic multi-region failover if backends become unhealthy.
No pre-warming is required.
Cross-regional load balancing for a web app is provided by the _Global HTTP(S) load balancer_.

## Other TCP load balancers
These proxy services only work for specific port numbers and only for TCP:
1. For SSL traffic that isn't HTTP use the _Global SSL Proxy load balancer_.
1. For other TCP traffic that isn't SSL use the _Global TCP Proxy load balancer_.

## UDP traffic
For UDP traffic, or traffic on another port, you can:
1. Load balance across a region with the _Regional External Passthrough Network load balancer_
1. On top of that, a _Regional External Application load balancer_ or _Proxy Network load balancer_

## Internal load balancing
All the aforementioned load balancers are intended for traffic coming into the Google network from the internet
Within a project, you can use the _Regional Internal load balancer_ which supports:
1. Proxy Network load balancer
1. Passthrough Network load balancer
1. Application load balancer
The Regional internal load balancer accepts traffic on a GCP internal IP and balances across GCE VMs.
The _Cross-region internal load balancer_ is a Layer 7 load balancer that enables balancing traffic to backend services globally, including traffic managemtn to send traffic to the closest backend.
