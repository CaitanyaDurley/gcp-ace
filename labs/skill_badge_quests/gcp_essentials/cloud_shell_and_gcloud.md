## Configuring env
```sh
# Set GCE defaults
gcloud config set compute/region REGION
# Get GCE defaults
gcloud config get-value compute/region
```

## Filtering gcloud env output
```sh
# List the gcelab2 VM
gcloud compute instances list --filter="name('gcelab2')"
# List the firewall rules for the default network
gcloud compute firewall-rules list --filter="network='default'"
# Find firewall rules on the default network which allow ICMP
gcloud cmopute firewall-rules list --filter="NETWORK:'default' AND ALLOW:'icmp'"
# Get external ip of VM
gcloud compute instances list --filter=name:gcelab2 --format='value(EXTERNAL_IP)'
```

## Adding firewall rules
```sh
# Tag your GCE instance
gcloud compute instances add-tags name --tags http-server,https-server
# Add a firewall rule for VMs with this tag
gcloud compute firewall-rules create default-allow-http --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:80 --source-ranges=0.0.0.0/0 --target-tags=http-server
```

## System logs
```sh
# View logs relating to compute resources
gcloud logging logs list --filter="compute"
# View logs for resource type gce_instance
gcloud logging read "resource.type=gce_instance" --limit 5
# Read logs for a specific VM
gcloud logging read "resource.type=gce_instance AND labels.instance_name='name'" --limit 5
```