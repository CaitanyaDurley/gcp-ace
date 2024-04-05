# IAP
Lab: GSP499
We deploy multiple Flask apps on App Engine, leveraging IAP for authentication via the user's Google account and accessing their email/id in the app via headers IAP adds to the request.

## Sample application
Three versions:
1. Basic hello world application
1. Displays email and id obtained from headers
1. Verifies the digital signature supplied by IAP using Google's public keys
```sh
gsutil cp gs://spls/gsp499/user-authentication-with-iap.zip .
unzip user-authentication-with-iap.zip
# e.g. to deploy the first version
cd user-authentication-with-iap/1-HelloWorld
sed -i 's/python37/python39/g' app.yaml # update old python runtime
gcloud app deploy
```

## Enable IAP
1. Go to Security > Identity-Aware Proxy
1. Enable the API
1. Configure the consent screen
1. Select internal as the user type
1. Fill in the app's home page, privacy policy link and a developer contact
1. Add the homepage's domain as an authorised domain IAP can redirect to
1. Go to the IAP page again
1. Toggle IAP on for App Engine
Now that IAP is enabled, navigating to the app requires you to log in, but access will only be allowed to specified principals.
1. Return to the IAP page and select the App Engine app
1. Add principal:
    * Student email address
    * Role: IAP-Secured Web App User

## Acessing user information
The second version of the application retrieves user information from the following headers:
1. `X-Goog-Authenticated-User-Email`
1. `X-Goog-Authenticated-User-ID`
which are provided by IAP.
What happens if IAP is somehow bypassed?
Switch IAP off to simulate this and fake a request that appears to have passed through IAP with:
```sh
curl <app url> -H "X-Goog-Authenticated-User-Email: totally fake email"
```
The application has no way of verifying that IAP hasn't been bypassed.

## Cryptographic verification
The third version verifies the identity information it receives to be certain that it was provided by IAP and is unaltered.
It does so using a third header: `X-Goog-IAP-JWT-Assertion` which contains a JWT digitral signature.
