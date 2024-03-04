# Access
The creator of an instance has full root priveleges on that instance.
On a Linux instance, the creator has SSH capability and can grant SSH capability to other users.
On a Windows instance, the creator can generate a username and password for other users to RDP with.


# Lifecycle

## States
### Provisioning
Once all the properties of an instance have been defined, the instance enters provisioning state.
The resources are being reserved for the instance, but the instance is not running yet.
### Staging
The resources have been acquired and the instance is prepared for launch:
1. Adding IP addresses
1. Booting the system image
1. Booting the system
### Running
The instance goes through pre-configured startup scrips and enables SSH/RDP access.
You can do sever things while your instance is running:
1. Live migrate your VM to another host in the same zone - no reboot required, used during host maintenance
1. Move your VM to another zone
1. Take a snapshot of the VM's persistent disk
1. Export the system image
1. Reconfigure metadata
If needed, you can reset the VM which wipes the memory contents of the machine and resets it to its initial state.
During a reset the instance stays in the running state.
### Stopping
Some actions require stopping the VM, e.g. adding more CPU.
The instance will go through pre-configured shutdown scripts and end in the terminated state.
### Terminated
Once the instance is terminated you can either:
1. Restart the instance, which puts us back in the provisioning state
1. Delete it
You cannot however change the image of a stopped VM.
When a VM is termintaed you do not pay for memory/CPU.
You are still charged for any attached disks and reserved IP addresses though.
### Repairing
This state is entered when the VM encounters an internal error or the underlying machine is unavailable due to maintenance.
You are not billed when a VM is in repair.
VMs are not covered by the SLA when they are in repair.
If repair succeeds, the VM returns to one of the above states.
### Suspending/suspended
You can suspend the VM, after which you can resume or delete it.

## Changing state
Chaning a MV state from running can be done via:
1. The GCP console/gcloud
1. The OS - e.g. reboot/shutdown
When rebooting/stopping/deleting an instnace, the shutdown instance will take about 90s.
### Preemptible
For preemptible VMs, if the instance does not stop after 30s, GCE sends an _ACPI G3 Mechanical Off_ signal to the OS.
This is important when writing shutdown scripts for preemptible VMs.

## Availability policy
This determines how the instance behaves during a maintenance event. The default behaviour is to live migrate to another instance in the same zone, but you can change this to terminate your instance instead.
You can also change what should happen if the instance is terminated due to a crash. The default behaviour is to restart, but this can be changed.

These policies can be changed during instance creation and while an isntance is running by configuring the _Automatic restart_ and _On host maintenance_ options.

# OS patch management
When provisioining a premium image there is a cost associated with the image. 
This costs includes the usage of the OS and the _patch management_ of the OS.
OS patch management applies OS patches across a set of GCE instances.
There are two main components:
1. Patch compliance reporting - provides insights/recommendations on the patch status of your VMs
1. Patch deployment - schedules patch jobs
## Patch jobs
These run across VM instances and apply patches. There are several tasks that may be performed:
1. Create patch approvals - select what patches to apply from the full set of updates available
1. Set up flexible scheduling
1. Apply advanced patch config settings
1. Customise patches by adding pre/post patching scripts
