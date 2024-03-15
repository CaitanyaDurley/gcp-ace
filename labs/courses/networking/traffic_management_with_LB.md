# Traffic management with a LB
We create a _regional internal HTTP(s)_ LB with two backends.
Each backend is an instance group.
We configure the LB to create a blue-green deployment:
1. Blue is is the current version of your app - should receive 70% of traffic
1. Green is the new version of your app - should receive 30% of traffic

## Prerequisites
The following are already set up:
1. The `my-internal-app` network, with subnets `subnet-a` and `subnet-b`
1. Firewall rules for RDP, SSH and ICMP traffic
1. Firewall rules for communication between the LB and the backends
1. Firewall rules for health checks (TCP port 80)
1. Managed instance groups in `subnet-a` and `subnet-b`
1. The Cloud Router `nat-router` for the `my-internal-app` network - the LB will use the Cloud Router

## Create a test VM
Create in the `us-central1` region and attach to `subnet-a`, with a custom ephemeral IP of `10.10.20.50`.

## Create the LB
1. Go to Network Services > Load balancing
1. Create an `Application Load Balancer HTTP(s)`
1. For _Internet facing or internal only_, select _only between my VMs or serverless services_
1. For _Cross-region or regional_ select _Regional internal application load balancer_
1. Name = my-ilb, Region = us-central1, Network = my-internal-app
The proxy servers which implement the regional internal HTTP(s) LB require IP addresses.
These IPs are allocated automatically from a subnet you must specify for uniquely this purpose
1. Under _Proxy-only subnet required_ click _Reserve subnet_
1. Name = my-proxy-subnet, IP range = `10.10.40.0/24`
### Configure the backend services
1. Go to Backend configuration > create a backend service
1. Name = blue-service
1. Instance group = `instance-group-1`, port numbers = `80`
1. Create a health check:
    * Name = blue-health-check
    * Protocol = TCP
    * Port = 80
    * Check interval = 10s
    * Timeout = 5s
    * Healthy threshold = 2
    * Unhealthy threshold = 3
1. Similarly for the green-service
### Configure the routing rule
1. Go to Routing rules
1. Mode = _Advanced host and path rule_
1. Hosts = `*`
1. For the _Path matcher_ put:
```yaml
defaultService: regions/us-central1/backendServices/blue-service
name: matcher1
routeRules:
 - matchRules:
     - prefixMatch: /
   priority: 0
   routeAction:
     weightedBackendServices:
       - backendService: regions/us-central1/backendServices/blue-service
         weight: 70
       - backendService: regions/us-central1/backendServices/green-service
         weight: 30
```
### Configure the default routing rule
The LB doesn't know we've already matched all hosts.
So put `blue-service` as the default route for any unmatched hosts.
### Configure the frontend
1. Click _Frontend configuration_
1. Subnetwork = `subnet-b`, IP = _Ephemeral (Custom)_, Custom Ephemeral IP = `10.10.30.5`
