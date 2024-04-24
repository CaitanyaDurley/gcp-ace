# SSL proxy
SSL proxy is a global LB service for *encrypted non-HTTP* traffic.
The SSL connection is terminated at the LB layer, and load is balanced across your instances using SSL or TCP protocols.
Instances can be in multiple regions, and the LB will automatically direct traffic to the closest region with capacity.

## Features
1. Client traffic from IPv4 and IPv6 addresses
1. Intelligent routing - to back-end locations with capacity
1. Certificate management:
    *  Only need to update customer-facing certificates in one place when you need to switch them
    * Can use self-signed certificates on your instances
1. Automatic patching of SSL/TCP vulnerabilities

# TCP proxy
The TCP proxy is identical to the SSL proxy except that it is for *unencrypted non-HTTP* traffic.
The LB terminates your customer's TCP session and forwards traffic using either TCP or SSL.
