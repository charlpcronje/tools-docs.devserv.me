# Install Sprut.io

## Environment:

For correct file manager installation you will need an environment with Docker installed and no less than 1.5 Gb disk space. Installation documentation for Docker.

Docker can be installed for instance with a command:

```sh
wget -qO- https://get.docker.com/ | sh
```

Check that Docker is installed:

```sh
sudo docker run hello-world

# Hello from Docker.
# This message shows that your installation appears to be working correctly.
```


## Installation:

Enter server via SSH, go to directory where the file manager is installed.

```sh
mkdir /opt/sprutio
cd /opt/sprutio
```

launch command that will download installation script:

```sh
wget https://raw.githubusercontent.com/LTD-Beget/sprutio/master/run.sh
```

Give rights to execute command for the just downloaded file:

```sh
chmod +x run.sh
```

Launch the script:

```sh
./run.sh
```

Script will install and setup all the components on your server. Installation will take 5-10 minutes, you can go have a tea or something.

After installation, Docker containers will be launched. It can be viewed by command:

```sh
user@host:~$ docker ps

CONTAINER ID   IMAGE                  COMMAND                    NAMES
57cc6c3c2e2b   beget/sprutio-nginx    "nginx -g 'daemon off"     sprutio_nginx_1
3fbc26a6ecc1   beget/sprutio-app      "/init"                    sprutio_app_1
d6d539b09e5a   beget/sprutio-rpc      "/init"                    sprutio_rpc_1
41b22463e99a   beget/sprutio-cron     "/init"                    sprutio_cron_1
2ea18de7d54b   redis:3.0              "/entrypoint.sh redis"     sprutio_redis_1
```

Immediately after installation SPRUT.IO is available at https at an IP address of your server or domain at a 9443 port.

```sh
https://IP_вашего_сервера:9443
```

A self-signed certificate is installed as default option for the file manager. If you have your own SSL certificate, put it into the ssl folder and restart containers.

For authorization in the file manager use operating system users.

### Start

- To start one command is enough:

```sh
user@host:~$./run.sh
```

### Stop

- To stop one command is enough:

```sh
user@host:~$./run.sh stop
```

## Update

For update, download the latest images from docket hub, which can be done with command:

```sh
./run.sh pull
```

Have a nice work session!