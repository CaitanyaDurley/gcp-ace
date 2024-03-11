Sharing custom routes with peered VPC networks let networks learn routes directly from their peered networks.
When you create/modify a peering configuration, you can choose to import routes, export routes or both.
The peer network admin must similarly configure their peering configuration before routes are exchanged.
This ensures that both network admins explicitly agree to exchange custom routes before they are exchanged.

## Dynamic routes
For dynamic routes, you must add Cloud Router custom route advertisements in your VPC network.
These advertisements announce peered network subnets to your network.
Local routes are always preferred over dynamic routes that are learned using VPC Network Peering.

## Peering with a Shared VPC Network
You can establish a peering session with a Shared VPC Network.
This allows connectivity between all instances in the shared network and the peered network.
You can also set up network peering between two shared networks.

## Comparison
| Consideration | Shared VPC | VPC Network Peering |
| ------------- | ---------- | ------------------- |
| Across organisations | No | Yes |
| Within project | No | Yes |
| Network administration | Centralised | Decentralised |
