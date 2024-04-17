# Managed Instance Groups
A MIG is a collection of *identical* VMs controlled via an instance template.

## Features
You can perform a rolling update of all the instances in a group by specifying a new template.
When your applications require additional compute resources, MIGs can automatically scale the number of instances in the group.
MIGs can work with LB services to distribute network traffic to multiple instances.
If an instance in the group stops/crashes/is deleted (outside of the instance group commands), the MIG will automatically recreate the instance.
MIGs can automatically identify and recreate unhealthy instances.

## Regional vs Zonal
Regional MIGs are generally recommended:
1. So your application load can be spread across multiple zones without having to manage a MIG in multiple zones
1. To protect against zonal failures

## MIG types
There are three types of MIGs:
1. Stateless - for serving/batch workloads, e.g. website front end, image processing
1. Stateful - for stateful applications, e.g. a database. Supports disk and metadata preservation
1. Unmanaged - where you manage the VMs yourself

## Autoscaling
Autoscaling policies include:
1. CPU utilisation
1. LB capacity
1. Monitoring metrics
1. Queue-based workload like Pub/Sub
1. Schedule-based
### Health check
A health check is very similar to an uptime check in Stackdrivers.
You define a:
1. Protocol
1. Port
1. Health criteria, which defines:
    * check interval - how often to check
    * timeout - how long to wait for a response
    * healthy threshold - how many successful attempts are decisive
    * unhealthy threshold - how many failed attempts are decisive
