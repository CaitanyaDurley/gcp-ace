# Traffic management
Provides enhanced features to route LB traffic based on specified criteria.
With traffic management you can:
1. Steer traffic based on HTTPS params, e.g. host, path, headers, request params
1. Use traffic policies to fine-tune LB behaviour, e.g. retry policies, request mirroring, cross-origin resource sharing (CORS)
The traffic features available vary per LB.

## Supported LBs
Recall that all LBs offer backend services like:
1. Health checks
1. Session affinity
1. Balancing mode
1. Capacity scaling
However, only the following LBs support traffic management features:
1. Global external HTTP(s) (regular and classic)
1. Regional external HTTP(s)

## URL map
The URL map contains rules that define the criteria used to route incoming traffic to a backend service.
I.e., traffic management features are configured within a URL map and the LB consults the URL map to route traffic.
Each rule in a URL map is composed of:
1. A route rule
1. A rule match
1. A rule action

