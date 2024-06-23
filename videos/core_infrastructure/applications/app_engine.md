# App Engine
_App Engine_ is a serverless offering for running your application/microservice.
It is the predecessor of _Cloud Run_ and one of the oldest offerings by GCP.

## Environments
There are two environments available
### Standard environment
1. Your application runs in a sandbox using the standard runtime environment of a supported language
1. Intended to run for free or at very low cost - scales to 0 when no traffic
1. Can scale rapidly to meet extreme spikes of traffic
### Flexible environment
1. Your application runs in a Docker container on GCE instances - supports custom runtimes and other languages
1. Ideal for applications receiving consistent traffic - cannot scale to 0
1. Scales gradually

## App Engine vs Cloud Run
| | App Engine standard | App Engine flexible | Cloud Run |
|-| ------------------- | ------------------- | --------- |
| Scale to 0 | Yes | No | Yes |
| Warm up requests | Configurable | No | Automatic |
| Idle after last request | 15 mins | 15 mins | Depends on CPU allocation setting (use _always allocated_ to emulate App Engine) |
| Deploy from source | Yes | Yes | Yes |
| Deploy from container image | No | Yes | Yes |
| Billing | By uptime | By uptime | By uptime if CPU is always allocated, by request if CPU is only allocated during request processing (lower cost for idle instances) |
