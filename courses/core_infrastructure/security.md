## Hardware infrastructure layer
This layer comprises three key security features.
### Harware design and provenance
The server boards and networking equipment in Google data centers are custom-designed by Google.
Also design custom chips, including a custom hardware security chip.
### Secure boot stack
Google servers use multiple technologies to ensure they are booting the correct software stack.
E.g. cryptographic signatures over the:
1. BIOS
1. Bootloader
1. Kernel
1. Base operating system image
### Premises security
Google designs and builds its own data centers.
Access is limited to a very small number of Google employees.
Servers in third-party data centers have google-controlled physical security measures.

## Service deployment layer
Encryption of inter-service communication:
1. Cryptographic privacy and integrity for RPC data on the network
1. Google's services communicate with each other using RPC calls
1. Infra automatically encrypts all infra RPC traffic between data centers
1. In progress of deploying crypto accelerators that will extend this default encryption to all infra RPC traffic within Google data centers

## User identity layer
Google's central identity service:
1. Login page
1. Challenge users for additional info based on risk factors, e.g. whether they have logged in from the same device/location in the past
1. Secondary factors when signing in, e.g. Universal 2nd Factor (U2F) open standard

## Storage services layer
Encryption at rest security feature.
Most applications at Google access physical storage via storage services, which apply encryption using centrally managed keys
Hardware encryption support is also enabled for HDDs and SSDs.

## Internet communication layer
1. Google services made available on the internet register themselves with an infra service called the _Google Front End_ (GFE) which ensures:
    * All TLS connections are ended using a public-private key pair and a X.509 certificate crom a CA
    * Best practices are followed e.g. supporting perfect forward secrecy
    * Protections against DoS attacks
### DoS protection
1. Google's infra scale can absorb many DoS attacks
1. Multi-tier, multi-layer DoS protections further reduce the risk of impact on a service running behind a GFE.

## Google's operational security layer
### Intrusion detection
Rules and machine intelligence give security teams warnings of possible incidents.
Google conducts red team exercies to measure and improve its mechanisms
### Insider risk
Google limits and actively monitors the activities of employees who have admin access to the infra.
### Employee U2F use
Employee accounts require use of U2F-compatible security keys
### Stringent software development practices
Central source control and two-party code review.
Also libraries that prevent certain classes of security bugs.
