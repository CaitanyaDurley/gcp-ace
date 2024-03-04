# SSD persistent disk
## Create VM and disk
Through the console, call the disk "minecraft-disk".

## Format and mount
SSH to the VM
```sh
# Create a directory as the mount point
sudo mkdir -p /home/minecraft
# Format the disk
sudo mkfs.ext4 -F -E lazy_itable_init=0,lazy_journal_init=0,discard \
    /dev/disk/by-id/google-minecraft-disk
# Mount the disk
sudo mount -o discard,defaults /dev/disk/by-id/google-minecraft/disk /home/minecraft
```

## Schedule regular backups to GCS
```sh
# Create a bucket
gcloud storage buckets create gs://$BUCKET_NAME
# Create a backup script on the host with the following:
#!/bin/bash
/usr/bin/gcloud storage cp -R ${BASH_SOURCE%/*}/world gs://${YOUR_BUCKET_NAME}/$(date "+%Y%m%d-%H%M%S")-world

# Make executable
sudo chmod 755 /home/minecraft/backup.sh
# Crontab
sudo crontab -e
# Add: 0 */4 * * * /home/minecraft/backup.sh
```

## Mount on start
We can specify a startup script in the VM's metadata to mount the SSD.
1. Click on your instance then Edit
1. Metadata > Add Item:
    * Key: startup-script-url
    * Value: https://storage.googleapis.com/cloud-training/archinfra/mcserver/startup.sh
