---
title: sysPass
---
<script type="text/javascript">(function(w,s){var e=document.createElement("script");e.type="text/javascript";e.async=true;e.src="https://cdn.pagesense.io/js/webally/f2527eebee974243853bcd47b32631f4.js";var x=document.getElementsByTagName("script")[0];x.parentNode.insertBefore(e,x);})(window,"script");</script>

## Install with Portainer

Open portainer (How to [Setup Portainer](https://setup.docs.cronje.me/portainer))

- Click on Stacks
- Add Stack
- Paste the following in the docker compose field

```yml
version: '2'
services:
  app:
    container_name: syspass-app
    image: syspass/syspass:3.1.0 # Set this version tag to desired one
    restart: always
    # Will listen on ports 80 and 443 of the host
    ports:
      - "6925:80"
      - "6943:443"
    depends_on:
      - db
    volumes:
      - syspass-config:/var/www/html/sysPass/app/config
      - syspass-backup:/var/www/html/sysPass/app/backup
    # Set USE_SSL=no if you're using a LB or reverse proxy for SSL offloading
    environment:
      - USE_SSL=no
  db:
    container_name: syspass-db
    restart: always
    image: mariadb:10.2
    # Set a secure password for MariaDB root user
    environment:
      - MYSQL_ROOT_PASSWORD=syspass
    # This ports will only be accesible internally
    expose:
      - "3306"
    volumes:
      - syspass-db:/var/lib/mysql

# Persistent volumes to be used across updates
volumes:
  syspass-config: {}
  syspass-backup: {}
  syspass-db: {}
```