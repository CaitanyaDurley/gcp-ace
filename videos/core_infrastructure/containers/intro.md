A container is an invisible box around your code and its dependencies (including the OS it runs on) with limited access to its own partition of the host's file system and hardware.

The host requirements are:
1. An OS kernel that supports containers
1. A container runtime

Since all code's dependencies are in the container, the OS and hardware can be treated as a black box.

Scaling out a containerised workload can be done very quickly on a single host.
