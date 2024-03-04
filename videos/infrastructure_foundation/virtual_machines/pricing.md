# Pricing model
All vCPUs, GPUs and GB of memory are charged per-second with a minimum of 1 minute.
Each resource (vCPU and GB of memory) is billed separately rather than as part of a single machine type.

## Discounts
There are several discounts available, but htey cannot be combined.
### Committed-use
If your workload is stable and predictable, you can purchase vCPU/memory at a discount by committing to a usage term of 1 year or 3 years.
The discount is up to 57% for most machine types (including custom).
The discount is up to 70% for memory-optimised machine types.
### Spot VMs
Preemptible VMs are much cheaper to run but might be terminated by GCE if it requires those resources.
Preemptible VMs can only run for up to 24h at a time - spot VMs do not have a maximum runtime.
### Sustained use
These are automatic discounts you get for running GCE resources for a significant portion of the billing month.
For each minute you use above 25% of the month you get a discount, up to a maximum 30% net discount for instances that run the entire month.
The sustained use discounts are calculated separately by:
1. Resource - i.e. vCPU or memory
1. Region - but across zones
1. Predefined machine types
1. Custom machine types
