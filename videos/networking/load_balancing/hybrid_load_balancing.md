# Hybrid LB
Lets you extend Cloud LB to workloads running outside of GCP.
To configure a load balancer backend service to communicate to external endpoints use a hybrid NEG.
The external environments can use Cloud Interconnect or Cloud VPN to communicate with GCP.

## Hybrid NEG
To configure backend services outside of GCP:
1. Configure one or more hybrid NEGs
1. Add each `IP:port` endpoint to a hybrid NEG
1. Set the network endpoint type to `NON_GCP_PRIVATE_IP_PORT`
### Points to remember
1. Create the NEG in a zone as close as possible to your other environment
1. Hybrid connectivity NEGs must only include endpoints outside GCP

## Available LBs
The following LBs support hybrid load balancing:
1. Global external HTTP(s) (regular and classic)
1. Regional external HTTP(s)
1. Internal HTTP(s)
1. External TCP proxy
1. External SSL proxy
1. Internal regional TCP proxy
1. External regional TCP proxy
1. External TCP/UDP network
1. Internal TCP/UDP

## Caveats
1. To create/delete/manage a backend service with mixed zonal and hybrid NEG backends, you must use the gcloud CLI or the REST api
1. Regional dynamic routing and static routes are not supported
1. Internal HTTP(s) LB and hybrid connectivity must be configured in the same region
1. Ensure you review the security settings on your hybrid connectivity config. Currently:
    * HA Cloud VPN connections are encrypted by default
    * Cloud Interconnect connections are not encrypted by default
