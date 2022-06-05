# Install (Entity Rescource Planning) ERPNext with Docker Compose

## Prepare

Clone `frappe_docker` repo for the needed YAMLs and change the current working director of you shell to the cloned repo.

```shell
git clone https://github.com/frappe/frappe_docker
cd frappe_docker
```

Create configuration and resources directory

```shell
mkdir ~/gitops
```

The `~/gitops` directory will store all the resources that we use for setup. We will also keep the environment files in this directory as there will be multiple projects with different environment variables. You can create a private repo for this directory and track the changes there.

## Install Traefik

Basic Traefik setup using docker compose.

Create a file called `traefik.env` in `~/gitops`

```shell
echo 'TRAEFIK_DOMAIN=traefik.example.com' > ~/gitops/traefik.env
echo 'EMAIL=admin@example.com' >> ~/gitops/traefik.env
echo 'HASHED_PASSWORD='$(openssl passwd -apr1 changeit | sed 's/\$/\\\$/g') >> ~/gitops/traefik.env
```

Note:

- Change the domain from `traefik.example.com` to the one used in production. DNS entry needs to point to the Server IP.
- Change the letsencrypt notification email from `admin@example.com` to correct email.
- Change the password from `changeit` to more secure.

env file generated at location `~/gitops/traefik.env` will look like following:

```env
TRAEFIK_DOMAIN=traefik.example.com
EMAIL=admin@example.com
HASHED_PASSWORD=$apr1$K.4gp7RT$tj9R2jHh0D4Gb5o5fIAzm/
```

Deploy the traefik container with letsencrypt SSL

```shell
docker compose --project-name traefik \
  --env-file ~/gitops/traefik.env \
  -f docs/compose/compose.traefik.yaml \
  -f docs/compose/compose.traefik-ssl.yaml up -d
```

This will make the traefik dashboard available on `traefik.example.com` and all certificates will reside in `/data/traefik/certificates` on host filesystem.

For LAN setup deploy the traefik container without overriding `docs/compose/compose.traefik-ssl.yaml`.

## Install MariaDB

Basic MariaDB setup using docker compose.

Create a file called `mariadb.env` in `~/gitops`

```shell
echo "DB_PASSWORD=changeit" > ~/gitops/mariadb.env
```

Note:

- Change the password from `changeit` to more secure.

env file generated at location `~/gitops/mariadb.env` will look like following:

```env
DB_PASSWORD=changeit
```

Note: Change the password from `changeit` to more secure one.

Deploy the mariadb container

```shell
docker compose --project-name mariadb --env-file ~/gitops/mariadb.env -f docs/compose/compose.mariadb-shared.yaml up -d
```

This will make `mariadb-database` service available under `mariadb-network`. Data will reside in `/data/mariadb`.

## Install ERPNext

### Create first bench

Create second bench called `erpnext-one` with `one.example.com` and `two.example.com`

Create a file called `erpnext-one.env` in `~/gitops`

```shell
cp example.env ~/gitops/erpnext-one.env
sed -i 's/DB_PASSWORD=123/DB_PASSWORD=changeit/g' ~/gitops/erpnext-one.env
sed -i 's/DB_HOST=/DB_HOST=mariadb-database/g' ~/gitops/erpnext-one.env
sed -i 's/DB_PORT=/DB_PORT=3306/g' ~/gitops/erpnext-one.env
echo 'ROUTER=erpnext-one' >> ~/gitops/erpnext-one.env
echo "SITES=\`one.example.com\`,\`two.example.com\`" >> ~/gitops/erpnext-one.env
echo "BENCH_NETWORK=erpnext-one" >> ~/gitops/erpnext-one.env
```

Note:

- Change the password from `changeit` to the one set for MariaDB compose in the previous step.

env file is generated at location `~/gitops/erpnext-one.env`.

Create a yaml file called `erpnext-one.yaml` in `~/gitops` directory:

```shell
docker compose --project-name erpnext-one \
  --env-file ~/gitops/erpnext-one.env \
  -f compose.yaml \
  -f overrides/compose.erpnext.yaml \
  -f overrides/compose.redis.yaml \
  -f docs/compose/compose.multi-bench.yaml \
  -f docs/compose/compose.multi-bench-ssl.yaml config > ~/gitops/erpnext-one.yaml
```

For LAN setup do not override `compose.multi-bench-ssl.yaml`.

Use the above command after any changes are made to `erpnext-one.env` file to regenerate `~/gitops/erpnext-one.yaml`. e.g. after changing version to migrate the bench.

Deploy `erpnext-one` containers:

```shell
docker compose --project-name erpnext-one -f ~/gitops/erpnext-one.yaml up -d
```

Create sites `one.example.com` and `two.example.com`:

```shell
# one.example.com
docker compose --project-name erpnext-one exec backend \
  bench new-site one.example.com --mariadb-root-password changeit --install-app erpnext --admin-password changeit
```

You can stop here and have a single bench single site setup complete. Continue to add one more site to the current bench.

```shell
# two.example.com
docker compose --project-name erpnext-one exec backend \
  bench new-site two.example.com --mariadb-root-password changeit --install-app erpnext --admin-password changeit
```

### Create second bench

Setting up additional bench is optional. Continue only if you need multi bench setup.

Create second bench called `erpnext-two` with `three.example.com` and `four.example.com`

Create a file called `erpnext-two.env` in `~/gitops`

```shell
curl -sL https://raw.githubusercontent.com/frappe/frappe_docker/main/example.env -o ~/gitops/erpnext-two.env
sed -i 's/DB_PASSWORD=123/DB_PASSWORD=changeit/g' ~/gitops/erpnext-two.env
sed -i 's/DB_HOST=/DB_HOST=mariadb-database/g' ~/gitops/erpnext-two.env
sed -i 's/DB_PORT=/DB_PORT=3306/g' ~/gitops/erpnext-two.env
echo "ROUTER=erpnext-two" >> ~/gitops/erpnext-two.env
echo "SITES=\`three.example.com\`,\`four.example.com\`" >> ~/gitops/erpnext-two.env
echo "BENCH_NETWORK=erpnext-two" >> ~/gitops/erpnext-two.env
```

Note:

- Change the password from `changeit` to the one set for MariaDB compose in the previous step.

env file is generated at location `~/gitops/erpnext-two.env`.

Create a yaml file called `erpnext-two.yaml` in `~/gitops` directory:

```shell
docker compose --project-name erpnext-two \
  --env-file ~/gitops/erpnext-two.env \
  -f compose.yaml \
  -f overrides/compose.erpnext.yaml \
  -f overrides/compose.redis.yaml \
  -f docs/compose/compose.multi-bench.yaml \
  -f docs/compose/compose.multi-bench-ssl.yaml config > ~/gitops/erpnext-two.yaml
```

Use the above command after any changes are made to `erpnext-two.env` file to regenerate `~/gitops/erpnext-two.yaml`. e.g. after changing version to migrate the bench.

Deploy `erpnext-two` containers:

```shell
docker compose --project-name erpnext-two -f ~/gitops/erpnext-two.yaml up -d
```

Create sites `three.example.com` and `four.example.com`:

```shell
# three.example.com
docker compose --project-name erpnext-two exec backend \
  bench new-site three.example.com --mariadb-root-password changeit --install-app erpnext --admin-password changeit
# four.example.com
docker compose --project-name erpnext-two exec backend \
  bench new-site four.example.com --mariadb-root-password changeit --install-app erpnext --admin-password changeit
```

### Create custom domain to existing site

In case you need to point custom domain to existing site follow these steps.
Also useful if custom domain is required for LAN based access.

Create environment file

```shell
echo "ROUTER=custom-one-example" > ~/gitops/custom-one-example.env
echo "SITES=\`custom-one.example.com\`" >> ~/gitops/custom-one-example.env
echo "BASE_SITE=one.example.com" >> ~/gitops/custom-one-example.env
echo "BENCH_NETWORK=erpnext-one" >> ~/gitops/custom-one-example.env
```

Note:

- Change the file name from `custom-one-example.env` to a logical one.
- Change `ROUTER` variable from `custom-one.example.com` to the one being added.
- Change `SITES` variable from `custom-one.example.com` to the one being added. You can add multiple sites quoted in backtick (`) and separated by commas.
- Change `BASE_SITE` variable from `one.example.com` to the one which is being pointed to.
- Change `BENCH_NETWORK` variable from `erpnext-one` to the one which was created with the bench.

env file is generated at location mentioned in command.

Generate yaml to reverse proxy:

```shell
docker compose --project-name custom-one-example \
  --env-file ~/gitops/custom-one-example.env \
  -f docs/compose/compose.custom-domain.yaml \
  -f docs/compose/compose.custom-domain-ssl.yaml config > ~/gitops/custom-one-example.yaml
```

For LAN setup do not override `compose.custom-domain-ssl.yaml`.

Deploy `erpnext-two` containers:

```shell
docker compose --project-name custom-one-example -f ~/gitops/custom-one-example.yaml up -d
```
