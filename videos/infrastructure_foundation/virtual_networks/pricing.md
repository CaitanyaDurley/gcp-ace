# Network pricing
| Traffic type | Price (per GB) |
| ------------ | -------------- |
| Ingress | Free |
| Egress within zone | Free |
| Egress within region | $0.01 |
| Egress between US/CAN regions | $0.01 |
| Egress between other regions | Varies by region |
| Egress to Google products (YouTube/Maps/Drive) | Free |
| Egress to a GCP service within the same region | Free |

## Request/response
Responses to ingress requests do count as egress and are charged.
E.g. your load balancer will be billed for egress traffic.

## Use internal IPs
GCE cannot determine the zone of a VM through the external IP address.
Hence, if you send data to the public IP of a VM in the same zone, it will be billed as egress between zones in the same region.

## External IPs
Static and ephemeral _external_ IPs are themselves billable.
Unused static IPs are more expensive.
This table gives the external IP pricing for us-central1

| Type | Price (per hour) |
| ---- | ---------------- |
| Static IP assigned but unused | $0.01 |
| Static/ephemeral IP in use on standard VMs | $0.004 |
| Static/ephemeral IP in use on preemptible VMs | $0.002 |
| Static/ephemeral IPs attached to forwarding rules, used by Cloud NAT and Cloud VPN tunnel | Free |

