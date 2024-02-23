## Per-second billing
1. Compute Engine
1. Google Kubernetes Engine
1. Data Proc - Hadoop as a service
1. App Engine flexible environment VMs

## Sustained use discounts
Automatic discounts for running a VM instances for a significant portion of the billing month.
WHen you run an instance for more than 25% of a month, compute engine gives you a discount for every incremental minute.

## Budgets
Budgets can be defined at the billing acount level or at the project level.
Budgets can be a fixed limit or tied to another metric (e.g. a percentage of the previous month spend).
### Alerts
Alerts can notify you when you reach a percentage of your budget, e.g. 50%, 90% & 100%.

## Reports
A visual tool in the GCP console that allows monitoring of expenditure based on a project or services

## Quotas
These are desinged to prevent the over-consumption of resources due to:
1. An error
1. A malicious attack
Quotas protect the account owner and the GCP platform as a whole.
There are two types of quotas, both of which are applied at the project level:
1. Rate quotas - reset after a specific time, e.g. by default the GKE service implements a quota of 3K calls to its API from each GCP project every 100s
1. Allocation quotas - how many resources you can have in a project - e.g. by default a project cannot have more than 15 VPC networks
If needed, you can change quotas by requesting an increase from GCP support