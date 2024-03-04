# Configuring a VM
You can use the Cloud console, gcloud or the REST api.
To automate and process complex configurations, the API is recommended. The Cloud console can show the equivalent REST request once you have configured an instance through the console.

# Machine family
A machine family is a curated set of processor and hardware configurations optimised for specific workloads.
Once you've chosen a machine family, you can choose a predfined or custom machine type.
There are four GCE machine families
## General-purpose
1. Best price to performance
1. Most flexible vCPU to memory ratios
1. Targets most standard and cloud-native workloads
## E2
1. Day-to-day computing at a lower cost
1. Especially where there are no application dependencies on a specific CPU architecture
1. Variety of compute resources for the lowest price on GCE, especially when paired with comitted-use discounts
1. 2 to 32 vCPUs with a ratio of 0.5 to 8GB per vCPU
1. Good for web servers, small/medium databases, DEV/UAT envs
1. Offers shared-core machine types: 0.25 to 1 vCPUs with 0.5 to 8GB of RAM.
### Shared core
These are essentially less than 1vCPU. So instead of having a dedicated hyperthread (1vCPU), a single physical core is shared between vCPUs for multitasking.
They are cost-effective for small, non-resource intensive applications.
## N2
1. The next generation following the N1 VMs (which are roughly equivalent to the E2 family)
1. Most flexible, provide a balance between price and performance
1. Good for enterprise applications, medium/large databases, web/app serving workloads
1. Support committed/sustained use discounts
1. Latest second-generation scalable Intel processors
1. Up to 128 vCPUs and 0.5 to 8GB RAM per vCPU
1. Default processor is Cascade Lake for up to 80vCPUs and Ice Lake thereafter
### Machine Series: N2D
1. AMD-based general purpose VMs
1. EPYC Milan and EPYC Rome processors
1. Up to 224 vCPUs per node
## Tau Family
1. Cost effective for scale-out workloads
1. Supported by GKE
### Machine Series: Tau T2D
1. Built on the latest 3rd Gen AMD EPYCTM processors
1. Full x86 compatilbility
1. Good for web servers, containerised microservices, media transcoding, large Java apps
1. Fixed shapes: up to 60vCPUs and 4GB of memory per vCPU
### Machine Series: Tau T2A
1. First machine series to run on Arm processors
1. T2A runs on a 64 core Ampere Altra processor with an Arm instruction set and an all-core frequency of 3GHz.
## Compute-optimised
1. Highest performance per core on GCE
1. Up to 3TB of local storage can be attached
### Machine Series: C2
1. Best for AAA gaming, HPC, media transcoding
1. Good applications licensed per core which need high performance per core
1. Powered by high frequency Cascade Lake
1. Up to 3.8GHz sustained all-core turbo
1. Full transparency into the underlying architecture - enables advanced performance tuning
1. 4 to 60 vCPUs, up to 240 GB of memory
### Machine Series: C2D
1. Largest VM sizes for HPC
1. Largest available last-level cache per core
1. 2 to 112 vCPUs, 4GB memory per vCPU
1. 3rd Gen AMD EPYC Milan
### Machine Series: H3
1. 88 cores and 352GB of DDR5
1. Available on the Intel Sapphire Rapids and Google's custom Intel Infrastructure Processing Unit (IPU)
## Memory-optimised
The most compute and memory resources of any GCE machine family.
Ideal for workloads that require higher memory-to-vCPU ratios.
1. M1 machine series has up to 4TB of memory
1. M2 machine series has up to 12TB of memory
1. Good for large in-memory databases and data analytics
1. Up to 30% sustained use discounts
1. Up to 60% commited use discounts
### Machine series: M3
1. Up to 128 vCPUs, up to 30.5GB memory per vCPU
1. Intel Ice Lake platform
## Accelerator-optimised
1. This family is ideal for massively parallelised CUDA compute workloads
1. Optimal choice for workloads requiring GPUs
### Machine Series: A2
1. 12 to 96 vCPUs and up to 1360GB of memory
1. Each A2 machine type has a fixed number (up to 16) of NVIDIA Ampere A100 GPUs
1. An A100 GPU provides 40GB of GPU memory - ideal for LLMs and HPC
### Machine Series: G2
1. 4 to 96 vCPUs, up to 432GB of memory
1. Intel Cascade Lake
1. Well suited for CUDA0enabled ML training

# Custom machine types
These are ideal where the predefined machine types don't match your needs.
There is an additional cost to use a custom machine type.
There are still restrictions:
1. Only machine types with 1vCPU or an even number of vCPUs
1. Memory must be between 1GB and 8GB per vCPU
## Extended memory
If 8GB per vCPU is not enough, you can pay for extended memory.

# Zones
Each zone supports a combination of CPU platforms.
When you create an instnace in the zone, your instance will use the default processor supported in that zone.
E.g. an instance in the us-central1-a zone will use the Sandy Bridge processor.
