# Custom dynamic routes
1. Managed by Cloud Routers in the VPC network
1. Destinations always represent IP ranges outside your VPC network
1. The destinations are received from a BGP peer router

## BGP peer router
These are typically outside the Google network, e.g.:
1. On-prem
1. On another cloud provider

## Usage
Dynamic routes are used by:
1. Dedicated interconnect
1. Partner interconnect
1. HA VPN tunnels
1. Classic VPN tunnels that use dynamic routing

## Routes
Routes are added/removed automatically by Cloud Routers in your VPC network.
The routes apply to VMs according to the VPC network's dynamic routing mode.

## Example
1. You have an on-prem router in a colocation facility with a google peering edge
1. You are using Dedicated interconnect
1. Cloud Router handles the BGP advertisements and adds them as custom dynamic routes
1. Cloud router creates a BGP session for the VLAN attachment and its corresponding on-prem peer router
1. The Cloud Router receives the routes that your on-prem router advertises
1. The Cloud Router advertises routes for the GCP resources to the on-prem peer router
