---
title:  Passbolt setup using docker-compose
---
<script type="text/javascript">(function(w,s){var e=document.createElement("script");e.type="text/javascript";e.async=true;e.src="https://cdn.pagesense.io/js/webally/f2527eebee974243853bcd47b32631f4.js";var x=document.getElementsByTagName("script")[0];x.parentNode.insertBefore(e,x);})(window,"script");</script>

First, create the directory. I use `/opt/passbolt`. **Run all the following commands and place all the following files in that directory!**

First, initialize the folders with the correct permissions:

```sh
mkdir -p passbolt_gpg
chown -R 33:33 passbolt_gpg
```

Now create a `.env` file with random passwords (I recommend using `pwgen 30`):

```sh
MARIADB_ROOT_PASSWORD=meiJieseingi4dutiareimoh2Aiv5j
MARIADB_USER_PASSWORD=ohre3ye1oNexeShiuChaengahzuemo
````

Now place your docker-compose.yml:

```sh
# docker-compose.yml
version: '3.4'
services:
  mariadb:
    image: mariadb:latest
    environment:
      - MYSQL_DATABASE=passbolt
      - MYSQL_USER=passbolt
      - MYSQL_PASSWORD=${MARIADB_USER_PASSWORD}
      - MYSQL_ROOT_PASSWORD=${MARIADB_ROOT_PASSWORD}
    volumes:
      - ./mariadb_data:/var/lib/mysql
  passbolt:
    image: passbolt/passbolt:latest-ce
    tty: true
    depends_on:
      - mariadb
    environment:
      - DATASOURCES_DEFAULT_HOST=mariadb
      - DATASOURCES_DEFAULT_USERNAME=passbolt
      - DATASOURCES_DEFAULT_PASSWORD=${MARIADB_USER_PASSWORD}
      - DATASOURCES_DEFAULT_DATABASE=passbolt
      - DATASOURCES_DEFAULT_PORT=3306
      - DATASOURCES_QUOTE_IDENTIFIER=true
      - APP_FULL_BASE_URL=https://passbolt.mydomain.com
      - EMAIL_DEFAULT_FROM=passbolt@mydomain.com
      - EMAIL_TRANSPORT_DEFAULT_HOST=smtp.mydomain.com
      - EMAIL_TRANSPORT_DEFAULT_PORT=587
      - EMAIL_TRANSPORT_DEFAULT_USERNAME=passbolt@gepa-mbh.de
      - EMAIL_TRANSPORT_DEFAULT_PASSWORD=yei5QueiNa5ahF0Aice8Na0aphoyoh
      - EMAIL_TRANSPORT_DEFAULT_TLS=true
      - PASSBOLT_KEY_EMAIL=passbolt@mydomain.com
    volumes:
      - ./passbolt_gpg:/etc/passbolt/gpg
      - ./passbolt_web:/usr/share/php/passbolt/webroot/img/public
    command: ["/usr/bin/wait-for.sh", "-t", "0", "mariadb:3306", "--", "/docker-entrypoint.sh"]
    ports:
      - 17880:80
```

- Be sure to replace all the email addresses, domain names and SMTP credentials by the values appropriate for your setup.
- Now startup passbolt for the first time, it will initialize the database:

```sh
docker-compose up
```

You need to keep passbolt running during the following steps.

- First, we’ll send a test email:

```sh
docke-compose exec passbolt su -m -c "bin/cake passbolt send_test_email"
```

If you see

```sh
The message has been successfully sent!
```

then your SMTP config is correct. Otherwise, debug the error message, and, if neccessary, modify the `EMAIL_`… environment variables in `docker-compose.yml` and restart passbolt afterwards.

Now we’ll **create an admin user:**

```sh
docker-compose exec passbolt su -m -c "bin/cake passbolt register_user -u john.doe@mydomain.com -f John -l Doe -r admin" -s /bin/sh www-data
```

If you want to create a normal (non-admin) user, use `user` instead of `admin`:

```sh
docker-compose exec passbolt su -m -c "bin/cake passbolt register_user -u john.doe@mydomain.com -f John -l Doe -r admin" -s /bin/sh www-data
```

After that, the only thing left to do is to [create a `systemd` service to autostart your passbolt service:](https://techoverflow.net/2020/10/24/create-a-systemd-service-for-your-docker-compose-project-in-10-seconds/)

```sh
curl -fsSL https://techoverflow.net/scripts/create-docker-compose-service.sh | sudo bash /dev/stdin
```

Passbolt is now running on port `17880` (you can configure this using `docker-compose.yml`). Just configure your reverse proxy appropriately to point to this port.