# Monitoring
Cloud Monitoring dynamically configures monitoring after resources are deployed and has intelligent defaults for basic monitoring activities.
It can ingest the following data:
1. Metrics
1. Events
1. Metadata
From which insights can be generated through:
1. Dashboards
1. Charts
1. Alerts

## Metrics scope
This is the root entity that holds monitoring and configuration information.
Each metrics scope can have up to 375 monitored projects.
A metrics scope contains the custom insights, notification channels and group definitions you use with your monitored projects.
The metrics scope can access metric data from its monitored projects, but the data and log entries remain in the individual projects.
### Scoping project
The first monitored project in a metrics scope is called the _scoping project_ and must be specified when the metrics scope is created.
The scoping project's name becomes the name of your metrics scope.
### AWS connector
To access an AWS account, you must configure a project in GCP to hold the AWS connector.

## Access
All users of operations suite with access to that metrics scope have access to all data by default.
In order to give people different roles per-project and to control visibility to data, consider placing the monitoring of those projects in separate metrics scopes.

## Dashboards
You can create charts to display:
1. Instances' CPU utilisation
1. Packets/bytes sent and received
1. Packets/bytes dropped by firewalls

## Alerts
Alerting policies notify you when specific conditions are met.
E.g. when the network egress of your instance goes above a certain threshold for a certain timeframe.
### Uptime checks
Can be configured to test the availability of your public services from locations around the world.
The type can be:
1. HTTP
1. HTTPS
1. TCP
The resource to be checked can be:
1. App Engine application
1. GCE instance
1. URL of a host
1. AWS instance/LB
You can then create alerting policies based on the uptime check and the latency incurred at each location.

## Ops agent
The hypervisor responsible for running GCE instances canot see some of the internal metrics inside a VM, e.g. memory usage.
The _Ops Agent_ is the primary agent for collecting telemetry data from your instances.
The agent can be configured to collect data beyond system metrics, such as data from third party apps like:
1. Apache
1. mySQL and Oracle databases
1. SAP HANA
1. NGINX

You can also capture custom metrics, such as the number of users logged into a game server.
