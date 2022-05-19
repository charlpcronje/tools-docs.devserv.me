## Passbolt

## Install with Portainer

Open portainer (How to [Setup Portainer](https://setup.docs.cronje.me/portainer))

- Click on Stacks
- Add Stack
- Paste the following in the docker compose field

```yml
version: '3.4'
services:
  mariadb:
    image: mariadb:latest
    environment:
      - MYSQL_DATABASE=passbolt
      - MYSQL_USER=passbolt
      - MYSQL_PASSWORD=passbolt
      - MYSQL_ROOT_PASSWORD=passbolt
    volumes:
      - ./passbolt/mariadb_data:/var/lib/mysql
  passbolt:
    image: passbolt/passbolt:latest-ce
    tty: true
    depends_on:
      - mariadb
    environment:
      - DATASOURCES_DEFAULT_HOST=mariadb
      - DATASOURCES_DEFAULT_USERNAME=passbolt
      - DATASOURCES_DEFAULT_PASSWORD=passbolt
      - DATASOURCES_DEFAULT_DATABASE=passbolt
      - DATASOURCES_DEFAULT_PORT=3306
      - DATASOURCES_QUOTE_IDENTIFIER=true
      - APP_FULL_BASE_URL=https://pass.example.me
      - EMAIL_DEFAULT_FROM=admin@example.com
      - EMAIL_TRANSPORT_DEFAULT_HOST=smtp.example.com
      - EMAIL_TRANSPORT_DEFAULT_PORT=587
      - EMAIL_TRANSPORT_DEFAULT_USERNAME=admin@example.com
      - EMAIL_TRANSPORT_DEFAULT_PASSWORD=pass
      - EMAIL_TRANSPORT_DEFAULT_TLS=true
      - PASSBOLT_KEY_EMAIL=admin@example.com
    volumes:
      - ./passbolt_gpg:/etc/passbolt/gpg
      - ./passbolt_web:/usr/share/php/passbolt/webroot/img/public
    command: ["/usr/bin/wait-for.sh", "-t", "0", "mariadb:3306", "--", "/docker-entrypoint.sh"]
    ports:
      - 7880:80
```

Be sure to replace all the email addresses, domain names and SMTP credentials by the values appropriate for your setup.

Now startup passbolt for the first time, it will initialize the database:

First, we’ll send a test email:

```sh
docker-compose exec passbolt su -m -c "bin/cake passbolt send_test_email"

# The message has been successfully sent!
```