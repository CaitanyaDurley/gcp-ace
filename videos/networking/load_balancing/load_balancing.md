# Load balancers
GCP has many types of load balancers that can be divided into global and regional.

## Global
The global load balancers are:
1. HTTP(s)
1. SSL proxy
1. TCP proxy
These load balancers leverage the Google Front End (GFE) service - a software-defined, globally distributed system available from Google POPs.
Global load balancers manage redundancy, e.g. routing a request to a nearby region when the desired region is unavailable.
Use a global load balancer when:
1. Your users and instances are globally distributed
1. You need access to the same workloads and content
1. You want a single anycast IP

## Regional
The regional load balancers are:
1. Internal TCP/UDP - uses Andromeda, a software-defined network virtualisation stack made by GCP
1. Network TCP/UDP - uses Maglex, a large distributed software system
1. Internal HTTP(s) - a proxy-based Layer 7 load balancer
1. External HTTP(s)
1. Internal TCP proxy
These load balancers distribute traffic to instances in a _single_ region.
### Internal HTTP(s) load balancer
This LB lets you run and scale your services behind a _private_ IP.
The IP is accessible only in the region where the load balancer is located.

## Cloud Load Balancing
A load balancer receives client traffic - which can be external or internal.
The backend services define how to handle the traffic:
1. Where the traffic is distributed to
1. Which health check to use against the backends
1. If session affinity is used
1. Which other services are used (e.g. Cloud CDN or Identity-Aware Proxy)
The backends that Cloud Load Balancing route traffic to can be:
1. A managed instance group
1. A network endpoint group (NEG)
1. Cloud storage buckets
### Network endpoint group
A NEG is a configuration object that specifies a group of backend endpoints or services.
There are five types of NEGs:
1. Zonal
1. Internet
1. Serverless
1. Private Service Connect
1. Hybrid connectivity
A common use case is deploying services in containers, as in GKE, since the LB must be able to select a pod.
You can use NEGs as backends for some LBs and with _Traffic Director_.
#### Zonal
A zonal NEG contains one or more endpoints that can be GCE instances or services running thereupon.
Each endpoint is specified by an IP address and optionally a port.
#### Internet
An internet NEG contains a single endpoint hosted outside of GCP.
The endpoint is specified by `FQDN:port` or `IP:port`.
#### Serverless
A serverless NEG is a backend pointing to a:
1. Cloud Run
1. App Engine
1. Cloud Functions or
1. API Gateway
service in the same region as the NEG.
#### Private Service Connect
A Private Service Connect NEG contains a single endpoint that resolves to either a Google-managed regional API endpoint or a managed service published by using Private Service Connect.
#### Hybrid connectivity
A hybrid connectivity NEG points to Traffic Director services that run outside of GCP.
