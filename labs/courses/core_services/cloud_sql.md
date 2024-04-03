# Implementing Cloud SQL
In this lab, you configure a Cloud SQL server and connect a wordpress application to it using both a Private IP link and the Cloud SQL proxy to its external IP.
Most of this lab is through the UI.

## Creating the Cloud SQL DB
Points of note:
1. The server's machine configuration (i.e. how many cores) impacts the network throughput
1. You can use SSD or HDD storage
1. To enable access over private IP, the console sets up VPC peering between your network and the Google network where the Cloud SQL instance resides

## Configuring the proxy
Note the DB's _instance connection name_.
SSH to your application VM and:
```sh
wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O cloud_sql_proxy && chmod +x cloud_sql_proxy
export SQL_CONNECTION=[SQL_CONNECTION_NAME]
./cloud_sql_proxy -instances=$SQL_CONNECTION=tcp:3306 &
```