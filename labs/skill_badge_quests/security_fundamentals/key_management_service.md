# Cloud KMS
KMS is a key management service on GCP which provides encryption and decryption of plaintext as a service.
There are two main concepts:
1. KeyRing - useful for grouping keys, e.g. by environment
1. CryptoKey - the actual keys

## Create the keyring and key
```sh
gcloud kms keyrings create $KEYRING_NAME --location global
gcloud kms keys create $CRYPTOKEY_NAME --location global \
      --keyring $KEYRING_NAME \
      --purpose encryption
```

## Encryption/decryption
```sh
PLAINTEXT="my plaintext"
# Encrypt plaintext
curl -v "https://cloudkms.googleapis.com/v1/projects/$DEVSHELL_PROJECT_ID/locations/global/keyRings/$KEYRING_NAME/cryptoKeys/$CRYPTOKEY_NAME:encrypt" \
  -d "{\"plaintext\":\"$PLAINTEXT\"}" \
  -H "Authorization:Bearer $(gcloud auth application-default print-access-token)"\
  -H "Content-Type: application/json" \
| jq .plaintext -r
# Decrypt ciphertext
curl -v "https://cloudkms.googleapis.com/v1/projects/$DEVSHELL_PROJECT_ID/locations/global/keyRings/$KEYRING_NAME/cryptoKeys/$CRYPTOKEY_NAME:decrypt" \
  -d "{\"ciphertext\":\"$CIPHERTEXT\"}" \
  -H "Authorization:Bearer $(gcloud auth application-default print-access-token)"\
  -H "Content-Type:application/json" \
| jq .plaintext -r
```

## Permissions
In KMS, there are two major permissions:
1. `cloudkms.admin` allows creation of KeyRings and the ability to create, modify, disable and destroy CryptoKeys
1. `cloudkms.cryptoKeyEncrypterDecrypter` allows the user to call the encrypt and decrypt endpoints
```sh
# Assign a user the permission to manage the keyring
gcloud kms keyrings add-iam-policy-binding $KEYRING_NAME \
    --location global \
    --member user:$USER_EMAIL \
    --role roles/cloudkms.admin
# Assign a user the permission to encrypt and decrypt using the key
gcloud kms keyrings add-iam-policy-binding $KEYRING_NAME \
    --location global \
    --member user:$USER_EMAIL \
    --role roles/cloudkms.cryptoKeyEncrypterDecrypter
```