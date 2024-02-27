# L4 network load balancer
## Create web servers
```sh
# Create as many web servers as desired
gcloud compute instances create ww1 \
    --zone $ZONE \
    --tags network-lb-tag \
    --machine-type e2-small \
    --image-family debian-11 \
    --image-project debian-cloud \
    --metadata=startup-script='#!/bin/bash
        apt-get update
        apt-get install apache2 -y
        service apache2 restart
        echo "<h3>Web Server: www1</h3>" | tee /var/www/html/index.html'
# Allow (external) traffic on port 80
gcloud compute firewall-rules create www-firewall-network-lb \
    --target-tags network-lb-tag --allow tcp:80
# Verify each VM is reachable
gcloud compute instances list
curl http://<IP_ADDRESS>
```

## Create forwarding rule
```sh
# Create a static external IP for the LB
gcloud compute addresses create network-lb-ip-1 --region $REGION
# Add a legacy HTTP health check resource
gcloud compute http-health-checks create basic-check
# Create a target pool in the same region as the web server instances
# The target pool needs a health check for the LB to function
gcloud compute target-pools create www-pool \
    --region $REGION --http-health-check basic-check
# Add our instances to the pool
gcloud compute target-pools add-instances www-pool \
    --instances www1,www2,www3
# Add a forwarding rule - this is the LB
gcloud compute forwarding-rules create www-rule \
    --region $REGION \
    --ports 80 \
    --address network-lb-ip-1 \
    --target-pool www-pool
```

## Verify
```sh
# View the external IP of the www-rule forwarding rule used by the LB
IPADDRESS=$(gcloud compute forwarding-rules describe www-rule \
    --region $REGION --format json | jq -r .IPAddress)
# Spam the LB
while true; do curl -m1 $IPADDRESS; done
```

# HTTP load balancer
HTTP(S) Load Balancing is implemented on Google Front End (GFE).
GFEs are distributed globally and operate together using Google's global network and control plane.
You can configure URL rules to route some URLs to some instances and other URLs to other instances.
Requests are always routed to the instance group closest to the user which is appropriate for the request and has capacity.
The GCE instances must be in an instance group.

## Create web servers
```sh
# Create GCE instance template for our backend
gcloud compute instance-templates create lb-backend-template \
   --region=Region \
   --network=default \
   --subnet=default \
   --tags=allow-health-check \
   --machine-type=e2-medium \
   --image-family=debian-11 \
   --image-project=debian-cloud \
   --metadata=startup-script='#!/bin/bash
     apt-get update
     apt-get install apache2 -y
     a2ensite default-ssl
     a2enmod ssl
     vm_hostname="$(curl -H "Metadata-Flavor:Google" \
     http://169.254.169.254/computeMetadata/v1/instance/name)"
     echo "Page served from: $vm_hostname" | \
     tee /var/www/html/index.html
     systemctl restart apache2'
```
### Managed instance group
MIGs let you operate apps on multiple identical VMs.
You can make your workloads scalable and highly available using:
1. Autoscaling
1. Autohealing
1. Regional (multiple zone) deployment
1. Automatic updates
```sh
# Create a MIG based on the template
gcloud compute instance-groups managed create lb-backend-group \
    --template lb-backend-template --size 2 --zone $ZONE
```
### Allow health checks
The GCP health checking systems live at _130.211.0.0/22_ and _35.191.0.0/16_.
We need to create a firewall rule to allow ingress from these ranges against
the VMs we tagged.
```sh
gcloud compute firewall-rules create fw-allow-health-check \
    --network default \
    --action allow \
    --direction ingress \
    --source-ranges "130.211.0.0/22,35.191.0.0/16" \
    --target-tags allow-health-check \
    --rules tcp:80
```

## Create LB
### Setup backend service
```sh
# Create a health check for the VMs
gcloud compute health-checks create http http-basic-check --port 80
# Create a backend service with the health check
gcloud compute backend-services create web-backend-service \
    --protocol HTTP \
    --port-name http \
    --health-checks http-basic-check \
    --global
# Add our instance group as the backend for the service
gcloud compute backend-services add-backend web-backend-service \
    --instance-group lb-backend-group \
    --instance-group-zone $ZONE \
    --global
```
### Routing
```sh
# Create a global static external IP for the LB
gcloud compute addresses create lb-ipv4-1 --ip-version=IPV4 --global
# Note the IP address
gcloud compute addresses describe lb-ipv4-1 --format="get(address)" --global
# Create a URL map to route incoming requests to the default backend
gcloud compute url-maps create web-map-http --default-service web-backend-service
```
A URL map is a GCP configuration resource used to route requests to backend services/buckets.
E.g. with an external HTTP(S) load balancer you can use a single URL map to route requests to different destinations based on the rules configured in the URL map:
1. Requests for https://example.com/video go to one backend service
1. Requests for https://example.com/audio go to a different backend service
1. Requests for https://example.com/images go to a Cloud Storage backend bucket
1. Requests for any other host and path go to a default backend service
```sh
# Create a target HTTP proxy to route requests to your URL map
gcloud compute target-http-proxies create http-lb-proxy --url-map web-map-http
# Create a global forwarding rule to route to the proxy
gcloud compute forwarding-rules create http-content-rule \
    --address lb-ipv4-1 \
    --global \
    --target-http-proxy http-lb-proxy \
    --ports 80
```

## Verify
Go to Console > Network services > Load Balancing
Click on the `web-map-http` LB
Click on the backend and confirm the VMs are healthy
Go to `http://IP_ADDRESS`
