# DNS based traffic steering
Create a Geolocation routing policy to route client queries to the closest web server.

## Enable APIs
```sh
# Enable Compute Engine API
gcloud services enable compute.googleapis.com
# Enable Cloud DNS API
gcloud services enable dns.googleapis.com
# Check
gcloud services list
```

## Configure firewall
```sh
# Allow SSH from Identity Aware Proxies (IAP)
gcloud compute firewall-rules create fw-default-iapproxy --direction INGRESS --priority 1000 --network default --action ALLOW --rules tcp:22,icmp --source-ranges 35.235.240.0/20
# Allow HTTP traffic on web servers
gcloud compute firewall-rules create allow-http-traffic --direction INGRESS --priority 1000 --network default --action ALLOW --rules tcp:80 --source-ranges 0.0.0.0/0 --target-tags http-server
```

## Create client VMs
Create a client VM in each of Europe, US & Asia
```sh
# E.g. for Asia
gcloud compute instances create asia-client-vm --machine-type e2-micro --zone asia-south1-a
# If there are no resources available in asia-south1-a, pick another from this list
gcloud compute zones list | grep -iE 'NAME.*asia' | sed 's/NAME://i' | sort
```

## Create server VMs
Create a server VM in each of us-east1 and europe-west2
```sh
# E.g. for US
gcloud compute instances create us-web-vm --machine-type e2-micro --zone us-east1-c --network default --subnet default --tags http-server --metadata=startup-script='#!/bin/bash
    apt-get update
    apt-get install apache2 -y
    echo "Page served from: US" | tee /var/www/html/index.html
    systemctl restart apache2'
```

## Cloud DNS
### Get the internal IPs of the web servers
```sh
# E.g. for US
export US_WEB_IP=$(gcloud compute instances describe us-web-vm --zone us-east1-c --format "value(networkInterfaces.networkIP)")
```
### Create the Private Zone
We will use the `example.com` domain name for the private zone.
```sh
gcloud dns managed-zones create example --description test --dns-name example.com --networks default --visibility private
```
### Create Routing policy
We create an A record with a Time to Live of 5s.
The `routing_policy_data` field accepts a semicolon-delimited list of format `region:rrdata,rrdata`
```sh
# Create the geo.example.com recordset
gcloud dns record-sets create geo.example.com --ttl 5 --type A --zone example --routing-policy-type GEO --routing-policy-data "us-east1=$US_WEB_IP;placeholder=$EUROPE_WEB_IP"
# Check
gcloud dns record-sets list --zone example
```

## Testing
Europe client VM should always be routed to the europe web VM.
```sh
# SSH to europe client VM
gcloud compute ssh europe-client-vm --zone us-east1-c --tunnel-through-iap
for i in {1..10}; do
    echo $i
    curl geo.example.com
    # Sleep for 6s to outlive the DNS TTL of 5s
    sleep 6
done
```