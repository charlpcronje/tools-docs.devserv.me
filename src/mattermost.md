---
title: Install Mattermost
---
<script type="text/javascript">(function(w,s){var e=document.createElement("script");e.type="text/javascript";e.async=true;e.src="https://cdn.pagesense.io/js/webally/f2527eebee974243853bcd47b32631f4.js";var x=document.getElementsByTagName("script")[0];x.parentNode.insertBefore(e,x);})(window,"script");</script>

You’ll need [Docker Engine](https://docs.docker.com/engine/install/) and [Docker Compose](https://docs.docker.com/compose/install/) (release 1.28 or later) [Follow the steps in the Mattermost Docker Setup README](https://github.com/mattermost/docker#mattermost-docker-setup) or follow the steps below.

Encountering issues with your Docker deployment? See the Docker deployment troubleshooting documentation for details.

In a terminal window, clone the repository and enter the directory.

```sh
git clone https://github.com/mattermost/docker
cd docker
```

Create your `.env` file by copying and adjusting the `env.example` file.

```sh
cp env.example .env
```

## Important

At a minimum, you must edit the `DOMAIN` value in the `.env` file to correspond to the domain for your Mattermost server.

Create the required directories and set their permissions.

```sh
mkdir -p ./volumes/app/mattermost/{config,data,logs,plugins,client/plugins,bleve-indexes}
sudo chown -R 2000:2000 ./volumes/app/mattermost
```

Configure TLS for NGINX (optional). If you’re not using the included NGINX reverse proxy, you can skip this step.

If creating a new certificate and key:

```sh
bash scripts/issue-certificate.sh -d <YOUR_MM_DOMAIN> -o ${PWD}/certs
```

To include the certificate and key, uncomment the following lines in your .env file and ensure they point to the appropriate files.

```sh
#CERT_PATH=./certs/etc/letsencrypt/live/${DOMAIN}/fullchain.pem
#KEY_PATH=./certs/etc/letsencrypt/live/${DOMAIN}/privkey.pem
```

If using a pre-existing certificate and key:

```sh
mkdir -p ./volumes/web/cert
cp <PATH-TO-PRE-EXISTING-CERT>.pem ./volumes/web/cert/cert.pem
cp <PATH-TO-PRE-EXISTING-KEY>.pem ./volumes/web/cert/key-no-password.pem
```

To include the certificate and key, ensure the following lines in your .env file points to the appropriate files.

```sh
CERT_PATH=./volumes/web/cert/cert.pem
KEY_PATH=./volumes/web/cert/key-no-password.pem
```

Configure SSO with GitLab (optional). If you want to use SSO with GitLab, and you’re using a self-signed certificate, you have to add the PKI chain for your authority. This is required to avoid the Token request failed: certificate signed by unknown authority error.

To add the PKI chain, uncomment this line in your .env file, and ensure it points to your pki_chain.pem file:

```sh
#GITLAB_PKI_CHAIN_PATH=<path_to_your_gitlab_pki>/pki_chain.pem
```

Then uncomment this line in your [docker-compose.yml] file, and ensure it points to the same pki_chain.pem file:

```sh
# - ${GITLAB_PKI_CHAIN_PATH}:/etc/ssl/certs/pki_chain.pem:ro
```

Deploy Mattermost.

Without using the included NGINX:

```sh
sudo docker-compose -f docker-compose.yml -f docker-compose.without-nginx.yml up -d
```

To access your new Mattermost deployment, navigate to `http://<YOUR_MM_DOMAIN>:8065/` in your browser.

To shut down your deployment:

```sh
sudo docker-compose -f docker-compose.yml -f docker-compose.without-nginx.yml down
```

Using the included NGINX:

```sh
sudo docker-compose -f docker-compose.yml -f docker-compose.nginx.yml up -d
```

To access your new Mattermost deployment via HTTPS, navigate to `https://<YOUR_MM_DOMAIN>/` in your browser.

To shut down your deployment:

```sh
sudo docker-compose -f docker-compose.yml -f docker-compose.nginx.yml down
```

Create your first Mattermost System Admin user, invite more users, and explore the Mattermost platform.

## Upgrade from mattermost-docker

For an in-depth guide to upgrading from the deprecated mattermost-docker repository, please refer to this document. For additional help pr questions, please refer to this issue.

Installing a different version of Mattermost
Shut down your deployment.

Run `git pull` to fetch any recent changes to the repository, paying attention to any potential env.example changes.

Adjust the `MATTERMOST_IMAGE_TAG` in the .env file to point your desired enterprise or team image version.

Redeploy Mattermost.

## Troubleshooting your production deployment

Docker
If deploying on an M1 Mac and encountering permission issues in the Docker container, redo the third step and skip this command:

```sh
sudo chown -R 2000:2000 ./volumes/app/mattermost
```

If having issues deploying on Docker generally, ensure the docker daemon is enabled and running:

```sh
sudo systemctl enable --now docker
```

To remove all data and settings for your Mattermost deployment:

```sh
sudo rm -rf ./volumes
Postgres
```

You can change the Postgres username and/or password (recommended) in the `.env` file.
