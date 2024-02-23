Google Cloud runs on Google's own global network
Advantages:
1. High throughput
1. Low latency

## Content caching nodes
The GCP network has over 100 content caching nodes worldwide.
These are high demand locations where content is cached.
Client requests are serviced from the location that will provide the quickest response time.

## Infra locations
1. North America
1. South America
1. Europe
1. Asia
1. Australia
Multiple service locations is important because choosing where to locate applications affects:
1. Availability
1. Durability
1. Latency - how long does a packet of info take to travel from source to destination

### Regions
Each location is divided into several regions - an independent geographic area.
Example: London, europe-west2

### Zones
Each region is comprised of multiple zones
A zone is an area where GCP resources are actually deployed.
A gcp customer might use resources in multiple zones within a region for improved fault tolerance.

## Redundancy
You can run resources in different regions for protection against issues with an entire region, e.g. a natural disaster.

## Multi-region
Some services support placing resources in _multi-region_.
Example: Cloud Spanner allows you to replicate the database's data in multiple zones across multiple regions.