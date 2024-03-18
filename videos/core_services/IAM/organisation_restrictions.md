# Organisation restrictions
Consider an employee accessing GCP from a managed device.
There is a need to restrict access only to resources in authorised GCP organisations, in order to prevent data exfiltration or phishing attacks.
An egress proxy administrator configures the proxy to add organisation restriction headers to any requests orginating from a managed device.
The _Organisation Restrictions_ feature in GCP inspects all requests for organisation restrictions header and allow or denies the requests based on which organisation is being accessed.

## Example uses
1. Only allow employees to access resources in your Google Cloud organisation
1. Allow your employees to read from GCS resources but only in your organisation
1. Allow your employees to access a vendor GCP organisation in addition to your organisation
