VM instances can run Linux and WIndows Server images provided by Google or any customsised versions of these images.

## Marketplace
Cloud Marketplace offers many predefined VM instances, so you don't need to manually ocnfigure the instance, storage/network or software.
Most software packages in Marketplace are available at no charge beyond the normal usage fees for cloud resources.
Some packages published by 3rd parties may charge mnothly fees.

## Billing
GCE bills by the second with a one-minute minimum charge.
Sustained-use discounts apply to VM instances running for more than 25% of the month.

### Committed-use discounts
For stable and predictable workloads, a specific amount of vCPUs and memory an be purcahsed at an upto 57% discount in return for committing to a usage term of 1 year or 3 years.

### Preemptible or Spot VM
GCE has permission to terminate these if resources are needed elsewhere.
In return you can save up to 90% on a standard GCE instance.
These are useful for workloads that don't require a human to sit and wait for it to finish.
To use a preemptible/spot VM you must ensure your job can be stopped and restarted.

Spot VMs differ from Preemptible VMs by offering more features, e.g. preemptible VMs can only run for up to 24h at a time. Whereas spot VMs do not have this restriction.
The pricing is currently the same for both.

## Scaling VMs
GCE has a feature called _Autoscaling_ where VMs can be added to/subtracted from an application based on load metrics.
VPCs support several different kinds of load balancing for splitting incoming traffic between the VMs.
