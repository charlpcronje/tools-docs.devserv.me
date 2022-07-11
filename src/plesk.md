---
title: Plesk Install with Docker
---
<script type="text/javascript">(function(w,s){var e=document.createElement("script");e.type="text/javascript";e.async=true;e.src="https://cdn.pagesense.io/js/webally/f2527eebee974243853bcd47b32631f4.js";var x=document.getElementsByTagName("script")[0];x.parentNode.insertBefore(e,x);})(window,"script");</script>

Dockerfiles for building Plesk images.

## Ready to Use Images

Ready to use images are published at [Docker Hub](https://hub.docker.com/r/plesk/plesk/).

Create a container based on published image for evaluation purposes:

```sh
docker run -d --tmpfs /tmp --tmpfs /run --tmpfs /run/lock -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 8880:8880 plesk/plesk
```

Use Docker host IP address and 8880 port for URL to open it in the browser. The following command can be used in the terminal:

```sh
open http://localhost:8880
```

Default login and password: `admin` / `changeme1Q**`

Create a container with typical port mapping:

```sh
docker run -d --tmpfs /tmp --tmpfs /run --tmpfs /run/lock -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 80:80 -p 443:443 -p 8880:8880 -p 8443:8443 -p 8447:8447 plesk/plesk
```

Automatic port mapping can be used to publish all exposed ports to random ports with high numbers:

```sh
docker run -d --tmpfs /tmp --tmpfs /run --tmpfs /run/lock -v /sys/fs/cgroup:/sys/fs/cgroup:ro -P plesk/plesk
```

## How To Build And Test

Here is an example on how to build the image manually:

```sh 
cd latest ; docker build --no-cache --build-arg "LICENSE=A00K00-F86R09-JFZ220-3Q4V67-QR2P43" -t plesk/plesk .
```

Create a container to test the image:

```sh
docker run -d --tmpfs /tmp --tmpfs /run --tmpfs /run/lock -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 8880:8880 plesk/plesk
```