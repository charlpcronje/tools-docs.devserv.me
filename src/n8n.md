---
title: Self-hosting n8n
---
<script type="text/javascript">(function(w,s){var e=document.createElement("script");e.type="text/javascript";e.async=true;e.src="https://cdn.pagesense.io/js/webally/f2527eebee974243853bcd47b32631f4.js";var x=document.getElementsByTagName("script")[0];x.parentNode.insertBefore(e,x);})(window,"script");</script>

- `n8n` is a workflow automation tool and it can integrate with most public `API's`. The reason why I'm using it to `automate` the deployment of software every time a new release of my software is added to `GITHUB`
- A release of `GitHub` is not something that happens with every commit, a release is created specifically when you are ready with the new version of your software and it is ready to be shipped to your clients.
- In many cases the deploy process is manual, so the engineers will log into each client server and copy the release to the server and run the release script and the check that everything was successful. This can be tedious, clients can be forgotten, maybe the clients don't want people to access their servers...
- with `n8n` you can monitor a `GitHub` `Repo` and some actions can be performed if something happens that you are monitoring. So in this case n8n will be watching for new releases, everything time there is one, it will attempt download it and run the installation. It will get the results of the action and report back to my sever and make an entry for each client. It can send Slack messages or emails or whatsApps if there were any issues, it can auto rollback the software if needed, it can even make a phone call and tell you was a problem

Above is just one workflow which I think with some thought and fine tuning can be used for deploying any software to any client and all the `reporting` and `installations` will happen automatically

- Youtube: [https://www.youtube.com/watch?v=sJO3b0WXm8I](https://www.youtube.com/watch?v=sJO3b0WXm8I)
- Youtube: [https://www.youtube.com/watch?v=0V-UtIK_6oI&t=3s](https://www.youtube.com/watch?v=0V-UtIK_6oI&t=3s)
- Youtube: [https://www.youtube.com/watch?v=GbN-SnK5cy4](https://www.youtube.com/watch?v=GbN-SnK5cy4)

## Running n8n

I created a bash script to start the container with some different settings:

```shell
sh /var/www/tools/n8n/start.sh

# Initializing n8n process
# UserSettings were generated and saved to: /home/node/.n8n/config
```

n8n can be access on CRONje.ME:5678

You can install via Docker or npm.

## npm

You can try n8n without installing it using npx.

From the terminal, run:

```shell
npx n8n
```

This command will download everything that is needed to start n8n. You can then access n8n and start building workflows by opening [http://localhost:5678](http://localhost:5678) (opens new window).

If you want to install n8n globally, use npm:

```shell
npm install n8n -g
```

After the installation, start n8n by running:

```shell
n8n
# or
n8n start
```

## 💡 Keep in mind

Windows users remember to change into the .n8n directory of your Home folder (~/.n8n) before running n8n start.

### Docker

See the Docker installation page for running n8n using Docker.

`n8n` also offers a `Docker` image for Raspberry Pi: `n8nio/n8n:latest-rpi`.

### n8n with tunnel

To be able to use webhooks for trigger nodes of external services like GitHub, n8n has to be reachable from the web. To make that easy, n8n has a special tunnel service (opens new window)which redirects requests from our servers to your local n8n instance.

If you installed `n8n` with `npm`, start `n8n` with `--tunnel` by running:

```shell
n8n start --tunnel
```

If you are running n8n with Docker, start n8n with --tunnel by running:

```shell
docker run -it --rm \
--name n8n \
-p 5678:5678 \
-v ~/.n8n:/home/node/.n8n \
n8nio/n8n \
n8n start --tunnel
```

## Using Docker

### Docker-Compose

Add A record to route the subdomain accordingly:

```txt
Type: A
Name: n8n (or the desired subdomain)
IP address: <IP_OF_YOUR_SERVER>
```

### Create docker-compose file

Create a `docker-compose.yml` file. Paste the following in the file:

```yml
#docker-compose.yml
version: "3"

services:
# Only run this service if you are not already running something NginX Proxy Manager
  traefik:
    image: "traefik"
    restart: always
    command:
      - "--api=true"
      - "--api.insecure=true"
      - "--providers.docker=true"
      - "--providers.docker.exposedbydefault=false"
      - "--entrypoints.web.address=:80"
      - "--entrypoints.web.http.redirections.entryPoint.to=websecure"
      - "--entrypoints.web.http.redirections.entrypoint.scheme=https"
      - "--entrypoints.websecure.address=:443"
      - "--certificatesresolvers.mytlschallenge.acme.tlschallenge=true"
      - "--certificatesresolvers.mytlschallenge.acme.email=${SSL_EMAIL}"
      - "--certificatesresolvers.mytlschallenge.acme.storage=/letsencrypt/acme.json"
    ports:
      - "9080:80"
      - "9443:443"
    volumes:
      - ${DATA_FOLDER}/letsencrypt:/letsencrypt
      - /var/run/docker.sock:/var/run/docker.sock:ro

  n8n:
    image: n8nio/n8n
    restart: always
    ports:
      - "127.0.0.1:5678:5678"
    labels:
      - traefik.enable=true
      - traefik.http.routers.n8n.rule=Host(`${SUBDOMAIN}.${DOMAIN_NAME}`)
      - traefik.http.routers.n8n.tls=true
      - traefik.http.routers.n8n.entrypoints=web,websecure
      - traefik.http.routers.n8n.tls.certresolver=mytlschallenge
      - traefik.http.middlewares.n8n.headers.SSLRedirect=true
      - traefik.http.middlewares.n8n.headers.STSSeconds=315360000
      - traefik.http.middlewares.n8n.headers.browserXSSFilter=true
      - traefik.http.middlewares.n8n.headers.contentTypeNosniff=true
      - traefik.http.middlewares.n8n.headers.forceSTSHeader=true
      - traefik.http.middlewares.n8n.headers.SSLHost=${DOMAIN_NAME}
      - traefik.http.middlewares.n8n.headers.STSIncludeSubdomains=true
      - traefik.http.middlewares.n8n.headers.STSPreload=true
    environment:
      - N8N_BASIC_AUTH_ACTIVE=true
      - N8N_BASIC_AUTH_USER
      - N8N_BASIC_AUTH_PASSWORD
      - N8N_HOST=${SUBDOMAIN}.${DOMAIN_NAME}
      - N8N_PORT=5678
      - N8N_PROTOCOL=https
      - NODE_ENV=production
      - WEBHOOK_URL=https://${SUBDOMAIN}.${DOMAIN_NAME}/
      - GENERIC_TIMEZONE=${GENERIC_TIMEZONE}
    volumes:
      - ${DATA_FOLDER}/.n8n:/home/node/.n8n
```

If you are planning on reading/writing local files with n8n (for example, by using the Write Binary File node, you will need to configure a data directory for those files here. If you are running n8n as a root user, add this under volumes for the n8n service:

```yml
      - /local-files:/files
```
If you are running n8n as a non-root user, add this under volumes for the n8n service:

```yml
      - /home/<YOUR USERNAME>/n8n-local-files:/files
```

You will now be able to write files to the /files directory in n8n and they will appear on your server in either `/local-files` or `/home/<YOUR USERNAME>/n8n-local-files`, respectively.

### Create .env file

Create an `.env` file and change it accordingly.

```conf
# Folder where data should be saved
DATA_FOLDER=/root/n8n/

# The top level domain to serve from
DOMAIN_NAME=example.com

# The subdomain to serve from
SUBDOMAIN=n8n

# DOMAIN_NAME and SUBDOMAIN combined decide where n8n will be reachable from
# above example would result in: https://n8n.example.com

# The user name to use for authentication - IMPORTANT ALWAYS CHANGE!
N8N_BASIC_AUTH_USER=user

# The password to use for authentication - IMPORTANT ALWAYS CHANGE!
N8N_BASIC_AUTH_PASSWORD=password

# Optional timezone to set which gets used by Cron-Node by default
# If not set New York time will be used
GENERIC_TIMEZONE=Africa/Johannesburg

# The email address to use for the SSL certificate creation
SSL_EMAIL=admin@srchosting.co.za
```

**Note:** If you want to use special characters in the password, use quotes. For example, N8N_BASIC_AUTH_PASSWORD="p@s$w0rd"

### Create data folder

Create the folder which is defined as `DATA_FOLDER`. In the example above, it is `/root/n8n/`.

In that folder, the database file from SQLite as well as the encryption key will be saved.

The folder can be created like this:

```sh
mkdir /root/n8n/
```

### Start docker-compose

n8n can now be started via:

```sh
sudo docker-compose up -d
```

To stop the container:

```sh
sudo docker-compose stop
```

### Done

n8n will now be reachable via the above defined `subdomain` + `domain combination`. The above example would result in: `https://n8n.example.com`

n8n will only be reachable via `https` and not via `http`