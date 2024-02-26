Most applications contain event driven parts, e.g. when a user uploads an image it might need processing.
If this function is integrated into the application you have to provide compute resources 24/7, regardless of how often it runs.

_Cloud Functions_ is a:
1. lightweight
1. event-based
1. async
compute solution that lets you create small, single-purposes functions that respond to cloud events.
You don't need:
1. a server
1. a runtime environment

## Billing
You're billed to the nearest 100ms, but only while your code is running (no bring-up/tear-down).

## Languages
1. Node JS
1. Python
1. Go
1. Java
1. Net core
1. Ruby
1. PHP

## Events
1. Events from GCS
1. Events from PubSub
1. HTTP invocation - for sync execution
