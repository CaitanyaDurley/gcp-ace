## Simple routing example
You can configure URL maps using a YAML file or via the Console.
```yaml
# If there is no matching host rule, use this defaultService
# Must specify a defaultService or a backendBucket
defaultService: /pathToTheService/web-backend-service
# Specify a pathMatcher for each set of hostnames
hostRules:
- hosts:
  - '*'
  pathMatcher: pathmap
name: lb-map
# List of path matching rules
pathMatchers:
# If there is no matching route rule, use this defaultService
- defaultService: /pathToTheService/web-backend-service
  name: pathmap
  pathRules:
  - paths:
    - /video/hd
    - /video/hd/*
    service: /pathToTheService/hd-video-service
  - paths:
    - /video/4K
    - /video/4K/*
    service: /pathToTheService/4K-video-service
```
Note the order of the specified path rules is irrelevant - path rules are evaluated on a longest-path-matches-first basis.

## Advanced routing
Advanced routing mode uses _route rules_ instead of _path rules_.
A rule is chosen based on a defined priority and includes additional configuration options.
Each URL map can include either simple or advanced rules, but not both.
E.g. this URL map routes 95% of traffic to service-a and 5% to service-b.
```yaml
pathMatchers:
- defaultService: global/backendServices/service-a
  name: matcher1
  routeRules:
  - matchRules:
    - prefixMatch: ''
    routeAction:
      weightedBackendServices:
      - backendService: global/backendServices/service-a
        weight: 95
      - backendService: global/backendServices/service-b
        weight: 5
```
The route action can also define traffic policies such as:
1. Retry policies
1. CORS

## Caveats
1. Wildcards are supported, but only after a forward slash, e.g.
  * Valid: `/video/*`
  * Invalid: `/video*`
1. Substring matching and regex are not supported
