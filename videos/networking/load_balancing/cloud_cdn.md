# Cloud CDN
Cloud CDN caches content at the edges of the Google network.
This provides faster content delivery to users while reducing transmission costs.
There are over 90 CDN nodes where content can be cached.
When setting up the backend service of a HTTP(s) LB, you can enable Cloud CDN with a single checkbox.

## Cache modes
Cache modes define:
1. How responses are cached
1. Whether Cloud CDN should respect cache directives sent by the origin
1. How cache TTLs are applied
There are three cache modes:
1. `USE_ORIGIN_HEADERS` - requires origin responses to set valid cache directives and caching headers
1. `CACHE_ALL_STATIC` - automatically caches static content that doesn't have the _no-store_, _private_ or _no-cache_ directive
1. `FORCE_CACHE_ALL` - cache everything, overriding any cache directives set by the origin. If you use a shared backend, ensure you don't cache private per-user content, e.g. dynamic HTML or API responses

## Response flow example
Consider a HTTP(s) LB with two types of backend:
1. Managed instance groups in the us-central1 and asia-east1 regions
1. GCS bucket in us-east1
A URL map decides which backend to send the content to.
When a user in San Fransisco is the first to access content, there is a cache miss. If content exists in a nearby cache, Cloud CDN might attempt to get the content from there. Otherwise the request is forwarded to the LB.
If the content from the backend is cacheable, the cache site in San Fransisco can store it for future requests.
Each Cloud CDN request is automatically logged with either "Cache hit" or "Cache miss" for each HTTP request against the LB.

# CDN Interconnect
CDN Interconnect lets you:
1. Select third-party Cloud CDN providers to establish Direct Interconnect links at edge locations in the Google network
1. Direct your traffic from your VPC networks to a CDN provider network
1. Optimise your Cloud CDN cache population costs

## Typical use cases
1. High volume egress - your network traffic that egresses from GCP through one of these links benefits from direct connectivity to supported CDN providers. CDN interconnect links will automatically optimise the egress traffic to save money.
1. Frequent content updates - the direct link to the Cloud CDN provider reduces latency

## Billing
For CDN Interconnect:
1. Ingress is free
1. Egress rates apply only to data that leaves GCE or GCS - these show on invoices as _Compute Engine Network Egress via Carrier Peering Network_
1. The special pricing for your traffic that egresses from GCP to a CDN provider is automatic
1. This reduced price applies only to IPv4 traffic
1. Intra-region pricing applies to intra-region egress sent to Google-approved CDN providers at specific locations
