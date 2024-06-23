_Cloud Run_ is a managed compute platform that runs *stateless* containers via web requests or Hub sub events.

## Features
1. Serverless, which means there is zero infrastructure management required.
1. Built on Knative - an open API and runtime environment built on K8s
1. Can be fully managed on GCP, GKE or anywhere Knative runs
1. Fast - can auto scale up and down from zero almost instantaneously
1. Charges only for resources used to the nearest 100ms

## Developer workflow
1. Write an application that starts a server and listens for web requests
1. Package your app into a container image
1. Push the image to _artifact registry_
1. Deploy with Cloud Run

This returns a unique HTTPS url back, and Cloud Run will start your container on demand as requests come in.

### Source-based workflow
In addition to the ocntainer-based workflow you can deploy source code instead of a container image.
Cloud Run builds the source and packages into a container image.
It also handles HTTPS serving for you.

## Pricing
You only pay for resources you use while a container is handling web requests or starting/shutting down - by default, when Cloud Run finishes processing a request the CPU is severely throttled (though this is configurable).
There is a small fee for every one million requests served.
The price of container time increases with CPU and memory.

## Languages
Cloud Run can run any binary compiled for Linux 64-bit.
In other words, there are very few language restrictions - you just have to handle web requests.
