## TPU
Google's _Tensor Processing Unit_ are custom-developed _application-specific integrated circuits_ used to accelerate ML workloads.
Their architecture is tailored to meet ML computation needs (e.g. matrix multiplication).
They are faster and significantly more energy-efficient for ML.
TPUs are recommended for models which train for long durations and for large models with large effective batch sizes.

## Network throughput
The network throughput of a GCE instance is determined by your choice of CPU:
1. Your network scales at 2Gbps for each CPU core, except
1. Instances with 2 or 4 CPUs receive up to 10Gbps of bandwidth
1. There is a theoretical maximum throughput of 200Gbps for a C3 machine series instance with 176 vCPU

## vCPUs and hyperthreading
On bare metal, you have physical cores, which each have hyperthreads.
On GCE, each vCPU is implemented as a single hardware hyper-thread.

## Disk
Three options:
1. Standard - spinning hard disk drives, more capacity per dollar
1. SSD - flash memory solid-state drives, more IOPS per dollar
1. Local SSD - higher throughput and lower latency
### Local SSD
These SSDs are attached to the physical hardware and so give better performance.
However, the data stored here persists only until the instance is stopped/deleted.
Typical usage is as a swap disk.
### Capacity and performance
Standard and non-local SSDs can be sized up to 257TB for each instance.
Performance of disks scales with each GB allocated.
