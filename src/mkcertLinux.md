---
title: MKCert on Linux (Create Locally Trusted SSL Certificate)
---
<script type="text/javascript">(function(w,s){var e=document.createElement("script");e.type="text/javascript";e.async=true;e.src="https://cdn.pagesense.io/js/webally/f2527eebee974243853bcd47b32631f4.js";var x=document.getElementsByTagName("script")[0];x.parentNode.insertBefore(e,x);})(window,"script");</script>

`Mkcert` is a simple tool used to make locally trusted development certificates. It requires no configurations to use making it a very efficient tool for developers to test their applications before deploying them for production purposes.

While using self-assigned certificates can cause trust issues, using real certificates from Certificate Authorities (CAs) for development is sometimes very impossible and at times it can be dangerous. Using your own CA is the best practice although you have to manually execute commands to use them.

Mkcert automatically creates and installs the local CA in the system root store and then generates a locally generated certificate for you. You then configure your server with the generated certificate.

Mkcert is fit for developers because it enables them to locally test their applications before they are deployed for production purposes. For production purposes, a license must be purchased from Certificate Authorities, commonly known as SSL Certificate.

Mkcert is therefore a very ideal tool for the developers. We now turn our focus on installation on Linux system.

## Step 1: Install Mkcert Tool on Linux

Installing mkcert in any Linux is a very simple process. Follow the steps below.

- Update system and install wget,curl

> As a matter of best practice, always update your system before any installation.

```sh
# RHEL based system
sudo yum update -y
sudo yum -y install wget curl

# Debian based systems
sudo apt update
sudo apt install wget curl
```
## Install certutil utility on your system

The `certutil` is a certificate database tool with a command-line utility to create and modify certificates and key databases. certutil Manage keys and certificates in both NSS databases and other NSS tokens

### To install mkcert dependencies

```sh
### RHEL Based Linux ###
sudo yum install nss-tools

### Debian based system ###
sudo apt update       
sudo apt install libnss3-tools
```

## Download and install mkcert on Linux

To download mkcert, you can visit the GitHub releases page. An alternative option is checking and downloading the latest available release for Linux using the following commands:

```sh
curl -s https://api.github.com/repos/FiloSottile/mkcert/releases/latest | grep browser_download_url | grep '\linux-amd64' | cut -d '"' -f 4 | wget -i -
```

The next step is to move and rename your file to /usr/bin/ folder.

```sh
sudo mv mkcert-v*-linux-amd64 /usr/bin/mkcert
```

Using Chmod command :

```sh
sudo chmod +x /usr/bin/mkcert
```

You can verify the version of mkcert installed by running the command:

```sh
$ mkcert --version
v1.4.3
```

## Generate Locally Trusted SSL Certificate with mkcert

### Generate Local CA

To generate a Local CA issue the command mkcert -install on your terminal.

```sh
$ mkcert -install
Created a new local CA 💥
The local CA is now installed in the system trust store! ⚡️
The local CA is now installed in the Firefox and/or Chrome/Chromium trust store (requires browser restart)! 🦊
```

A local CA has been installed. To locate the certificate, check the CA root directory.
 
```sh
mkcert -CAROOT
```

Command output is as shown below.

```sh
$ mkcert -CAROOT
/home/Jil/.local/share/mkcert
```

### Generate Local Certificate for Local website
To generate a Local Certificate for a test website (test.example.com) in the localhost 127.0.0.1

Execute the command:

```sh
mkcert test.example.com localhost 127.0.0.1 ::1
```

Command output:

```sh
$ mkcert test.example.com localhost 127.0.0.1 ::1
Created a new certificate valid for the following names 📜
 - "test.example.com"
 - "localhost"
 - "127.0.0.1"
 - "::1"

The certificate is at "./test.example.com+3.pem" and the key at "./test.example.com+3-key.pem" ✅

It will expire on 23 January 2024 🗓
```

To see the contents of the certificate :

```sh
cat ./test.example.com+3.pem
```

The output:

```sh
-----BEGIN CERTIFICATE-----
MIIEkTCCAvmgAwIBAgIRAKX56JBZ71PZMeN+1fzWVngwDQYJKoZIhvcNAQELBQAw
gZkxHjAcBgNVBAoTFW1rY2VydCBkZXZlbG9wbWVudCBDQTE3MDUGA1UECwwuSmls
QHJvY2t5LWxpbnV4LTAxLmxvY2FsZG9tYWluIChQaGlsaXAgTmR1bmd1KTE+MDwG
A1UEAww1bWtjZXJ0IEppbEByb2NreS1saW51eC0wMS5sb2NhbGRvbWFpbiAoUGhp
bGlwIE5kdW5ndSkwHhcNMjExMDIzMDgzNDI1WhcNMjQwMTIzMDkzNDI1WjBiMScw
JQYDVQQKEx5ta2NlcnQgZGV2ZWxvcG1lbnQgY2VydGlmaWNhdGUxNzA1BgNVBAsM
LkppbEByb2NreS1saW51eC0wMS5sb2NhbGRvbWFpbiAoUGhpbGlwIE5kdW5ndSkw
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDHO5BVBz3VPEDJGhpS1Qtp
r6lrzwBxOSIxYroROyV1wFUdVtFHVXMu24bVsSMGT/FKpGLkx97JrqhdJpFzK+Fl
DW2cRYCPxHBsVBGyuur3KfFCU46DdaF4Rka3QLWb/6cBbrYp2GMwCaXWMj2K0YY/
tsQcuTntqeU9yUL7RMA2NCqhTeqpk+QEkHsMbuJK+tWaA6XKtsdcM/5cL89GYy1m
Aw2HDxoJeNjdrOBCWBLb/Ra8qHKRVCbEuWSvwPcIUBs+B/iKmGxGHJRqi+S3qm0i
rkj3KsSAp9Ytz9oK9uQMnnwZi1DCMI1v4FCh26ubgdEawY2c9Bdd7VP/kXJKxh4l
-----END CERTIFICATE-----
```

To see the contents of the key generated.

```sh
cat ./test.example.com+3-key.pem
```

Command Execution.

```sh
-----BEGIN PRIVATE KEY-----
MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDHO5BVBz3VPEDJ
GhpS1Qtpr6lrzwBxOSIxYroROyV1wFUdVtFHVXMu24bVsSMGT/FKpGLkx97Jrqhd
JpFzK+FlDW2cRYCPxHBsVBGyuur3KfFCU46DdaF4Rka3QLWb/6cBbrYp2GMwCaXW
Mj2K0YY/tsQcuTntqeU9yUL7RMA2NCqhTeqpk+QEkHsMbuJK+tWaA6XKtsdcM/5c
L89GYy1mAw2HDxoJeNjdrOBCWBLb/Ra8qHKRVCbEuWSvwPcIUBs+B/iKmGxGHJRq
i+S3qm0irkj3KsSAp9Ytz9oK9uQMnnwZi1DCMI1v4FCh26ubgdEawY2c9Bdd7VP/
kXJKxh4lAgMBAAECggEAIUOCn4+r9TQwJONkzbugQi7//G39RuohGVnAcywK3xQT
oehi3KQZrRMd+gOvM1iZkrrLgCMWwVmV5qeP1UjYQwTw7gx0oIxNsOiAY/TtUgMA
svA8dRposSoamHIHYFpYydZwN6BXPyf9NjwBJnJBFdYv/BO45kNdcOlvc4BRDztv
Dhm+DzI2u18SKD95jJl7pq9KWikO/3Jm3IbpUEifIldni3+0ctRx1JE6Fd+zgm7U
7UJ/66rC4pFZUKeQGXl0QJRwPAiV3XBhBb7JLar186yw17eiUjzmTtx+irf06yC4
E0zid1WJCfCciYmx1S+liMvjQPll+MD2LmT68qwHKklpTVS4omL3/h2i+apN8aab
VDTTjY3wZioiABjx4frnHUfcC8iq/Nk58uY8/Fh7HpNcERzpcfc1M9WWeR1LvGYk
mNDsbxTIlX+/iTswfpkVodQ=
-----END PRIVATE KEY-----
```

Key details above have been edited.