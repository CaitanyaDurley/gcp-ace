# HTTP(s) Load Balancing
1. Acts at Layer 7 - the application layer, allowing for routing based on the URL
1. Global LB - via a single anycast IP
1. HTTP and HTTPS traffic across multiple back-end instances and across multiple regions
1. LB on ports:
    * 443 for HTTPs
    * 80 and 8080 for HTTP
1. Support for IPv4 and IPv6 clients
1. Requires no pre-warming

## Routing
You can configure URL maps to route some URLs to a certain set of instances.
Requests are generally routed to the instance group closest to the user with sufficient capacity.

## Architecture
Lets walk through the complete architecture of an HTTPs LB.
1. Global forwarding rule - directs incoming requests from the Internet to a
1. Target HTTP(d) proxy - checks each request against a
1. URL map - to determine, for a request, the appropriate
1. Backend service (alt. backend bucket) - directs each request to an appropriate
1. Backend - i.e. an instance group capable of handling the request
### Backend service
A backend service contains:
1. A health check
1. Session affinity - send all requests from the same client to the same instance
1. Timeout setting - how long to wait on the backend before considering the request a failure, default 30s
1. One or more attached backends
The backend service chooses an appropriate backend to handle a request based on their:
1. Serving capacity
1. Zone
1. Instance health
### Backend
A backend contains:
1. An instance group - can be managed (with or without autoscaling) or unmanaged
1. A balancing mode - how to determine if the backend is at full usage, either CPU utilisation or requests per second
1. Capacity scaler - a ceiling on CPU usage/RPS. E.g. you might have balancing mode at 80% CPU utilisation and capacity at 50%

## Example
Suppose we have a URL map with a single backend service (one logical part of the application).
We might attach two backends to that backend service:
1. NA-backend with a single MIG in us-central1
1. EMEA-backend with a single MIG in europe-west1

## SSL
In the case of HTTPs:
1. The LB uses a target HTTPS proxy instead of a target HTTP proxy
1. The target HTTPS proxy must have at least one signed SSL certificate installed on it
1. The client's SSL session is terminated at the LB
1. The LB supports the QUIC transport layer protocol:
    * Faster client connection initiation
    * Eliminates head-of-line blocking in multiplexed streams
    * Supports connection migration when a client's IP changes
### SSL certificates
The target proxy must have at least one SSL cert (and up to 15).
To create a SSL cert, you first create an _SSL certificate resource_:
1. This contains the SSL information
1. Are used only with the LB proxies

## Backend buckets
The URL map can direct traffic to either a backend service or a backend bucket.
This allows you to service static content easily.
