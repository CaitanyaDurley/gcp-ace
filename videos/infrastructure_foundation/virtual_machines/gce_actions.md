# Metadata server
Every VM instance stores its metadata on a metadata server.
Startup and shutdown scripts can use the metadata server to programmatically get unique information about an instance without additional authorisation.
E.g. get the instance's external IP and use it to set up a database.
It is recommended to store the startup/shutdown scripts in GCS.

# Moving an instance to a new zone
This can be done even if:
1. The VM is in a _terminated_ state
1. The instnace is a shielded VM that uses UEFI firmware
Moves within the same region can be automated using the `gcloud compute instances move` command.
To move the VM it must first be shut down.
After moving, andy target VMs or target pool must be updated.
## Moving region
To move you instance to another region requires manual work:
1. Make a snapshot of all persistent disks and create new disks in the destination zone from the snapshot
1. Create the new VM in the destination zone and attach the new persistent disks
1. Assign a static IP and update any references to the VM
1. Delete the original VM, its disks and the snapshot

# Snapshots
Snapshots are stored in GCS and can be used to:
1. Backup critical data into a durable storage solution
1. Migrate data between zones:
    * Between regions as discussed before
    * Also within a region, e.g. to migrate to a locally attached disk for lower latency
1. Transfer data from a standard HDD persistent disk to a SSD persistent disk

## How they work
Snapshots are only available for persistent disks - not lcoal SSDs.
Snapshots are different from public/custom images which are primarily used to create instances.
These are useful for periodic backup of the data on persistent disks.
They are incremental and automatically compressed so this is much cheaper than regularly creating a full image from the disk.
