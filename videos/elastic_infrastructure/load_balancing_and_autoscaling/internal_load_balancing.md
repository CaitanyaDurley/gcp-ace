# Internal load balancing
The internal TCP/UDP LB is:
1. Regional
1. Private - the LB is only accessible through a private IP

## Benefits
1. Internal requests stay internal to your VPC network and region
1. Lowered latency - since traffic stays within Google's network
1. Software defined LB
### Software defined
The internal LB is not based on a device or VM instance.
It is a *software-defined fully distributed* solution.
The traffic is not terminated at the LB and proxied to the backend, instead requests are distributed to backends using a lightweight network virtualisation stack called Andromeda.

## Internal HTTPS LB
The internal HTTPs LB is:
1. Proxy based - based on the open source Envoy proxy
1. Regional
1. Layer 7 - allows rich traffic control based on HTTPS parameters
and supports HTTP, HTTPS and HTTP/2 protocols.

## Three-tier web services
A traditional use case for an external HTTPS and internal TCP LB is the traditional _three tier_ model.
An external (global) HTTPS LB provides a single global IP for users.
The backends of this LB are frontend instances located in multiple regions.
These backends then access an internal LB in _each_ region to reach the application/data layer.
The backends of the internal LB serve up the data to the frontend servers.
The benefit here is that neither the data-based tier nor application tier is exposed externally.
This simplifies security and network pricing.
