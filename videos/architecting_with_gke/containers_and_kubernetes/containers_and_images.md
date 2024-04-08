# Containers and images
An _image_ is an application and its dependencies.
A _container_ is a running instance of an image.
Building software into images lets developers package and ship an application without worrying about the system it will run on.
It also allows for isolation of multiple applications' dependencies without requiring a different VM for each app, which can be wasteful.

## Docker
You need software to build container images and to run them.
Docker is an open-source technology that does both (but doesn't offer a way to orchestrate containers at scale).
You can use _Cloud Build_ to create Docker-formatted images.

## Containers
Containers are able to isolate workloads due to several technologies
### Linux process
Each proc in Linux:
1. Has its own virtual address space
1. Can be rapidly created and destroyed
### Linux namespaces
Namespaces in Linux control what an application can see:
1. PIDs
1. Directory trees
1. IP addresses
1. And more
### cgroups
_cgroups_ control what an application can use:
1. CPU time
1. Memory
1. IO bandwidth
1. Other resources
### Union file systems
_Union file systems_ efficiently encapsulate applications and their dependencies into a set of minimal layers.
When building an image, the tool you use reads instructions from a file called the _container manifest_ (a Dockerfile in Docker).
Each instruction therein specifies a layer in the image.
Each layer is read-only, except when a container runs the image - when a new container is launched a writable, but ephemeral, topmost layer is added on top of the underlying layers. This layer is often known as the _container layer_.
Each layer is essentially the deltas from the layer before it.
When writing the manifest, you should go organise the layers from least to most likely to change.

## Multi-stage build process
It's best practice to not include build tools in the same container which you ship to prod.
At best it's clutter, and at worst a potential attack surface.
A _multi-stage build process_ is where one container builds the final executable image, and a separate container receives only that.

## Artifact registry
The single place to store:
1. Container images
1. Language & OS packages
It is compatible with:
1. IAM - for access control
1. KMS - for customer managed encryption keys
1. Cloud Build - for CI/CD
1. Container Analysis - to scan for contianer vulnerabilities

## Cloud Build
Cloud Build can accept a Dockerfile and build the image.
However, it can also accept a yaml build configuration file in order to perform other actions in sequence or in parallel:
1. Build images
1. Pull code/resources from various locations
1. Run tests on newly built containers
1. Push images to various destinations
1. Deploy an image to GKE
