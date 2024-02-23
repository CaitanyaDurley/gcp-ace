There are four ways to interact with GCP:
1. Cloud Console
1. Cloud SDK & Cloud Shell
1. APIs
1. Google Cloud app

## GCP console
A GUI for finding resources, checking their health, have full mangement control, and set budgets.
The cloud console has a search facility to quickly find resources and connect to instances via SSH in the browser.

## Cloud SDK/Shell
The SDK is a set of tools you can use to manage resources and applications hosted on GCP.
These include:
1. The GCP CLI - the main command-line interface for GCP products
1. bq - the command-line tool for BigQuery
Cloud Shell provides command-line access to cloud resources from the browser. It is a Debian VM with a persistent 5GB home dir and Cloud SDK pre-isntalled.

## APIs
All GCP services offer APIs so you can write code to control them.
The Cloud Console has the _Google APIs Explorer_ that shows which APIs are available.
GCP provides _Cloud Client libraries_ and _Google API Client libraries_ in many languages to make calling GCP from your code easier.

## GCP app
The app can:
1. Start/stop and SSH to GCE instances
1. View logs from GCE instances
1. Start/stop Cloud SQL instances
1. Administer App Engine applications: viewing errors, roll backs, changing traffic splitting
1. View billing info/alerts for your projects
1. Customisable graphs for monitoring CPU/network/etc.