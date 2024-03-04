# Preemptible
1. 60% to 91% discount available
1. No charge if the VM is preempted in the first minute
1. Only live for up to 24 hours
1. Only get a 30s notification before the machine is preempted
1. No live migrations nor automatic restarts
## Manual restarts
You can set up monitoring and load balancers to start up a new preemptible VM in case of a failure.
This means you can keep restarting preemptible VMs if you need to and the workload can tolerate this.
## Spot VMs
These are the latest version of preemptible VMs.
The pricing model is the same but the main difference is spot VMs do not have a maximum runtime.
## Availability
The probability that GCE preempts spot VMs is generally low but varies day to day.
Spot VMs are also finite GCE resources, so they might not always be available.
Resources for Spot VMs come out of excess capacity - this is usually easier to get for smaller machine types.

# Sole-tenant nodes
This is a physical GCE server dedicated to hosting VM instances only for your project.
Useful for workloads that require physical isolation from other workloads/VMs (compliance).
You can run many VMs on the node so long as they all belong to the same project.
## OS licenses
If you have existing OS licenses you can use them on sole-tenant nodes while minimising the physical core usage with the _in-place restart_ feature.

# Shielded VMs
Offer verifiable integrity to your VM instances to protect against boot or kernel-level malware/rootkits.
This is the first offering in the Shielded Cloud Initiative.
To use shileded VMs, you must select a shielded image.

# Confidential VMs
These allow you to encrypt data in use, while it's being processed.
GCP lets you take advantage of this without any code changes or compromising performance.
The confidential VM is a type of N2D instance running on 2nd gen AMD EPYC Rome processors.
## SEV
AMD's _Secure Encrypted Virtualisation_ provides built-in optimisation for inline memory encryption without performance penalties on high-memory workloads.
Google does not have access to the encryption keys.
