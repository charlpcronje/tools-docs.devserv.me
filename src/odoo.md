# Install Odoo 15

There are two ways of install Odoo 15 and I guess Odoo 14 and some below and that is:

1. With the manual install using the RPM package and also installing the dependencies. 
2. The other easier way would be to just use the Docker image. With Docker you also have two popular options.
  - Using the official Docker image on hub.docker.com: [https://hub.docker.com/_/odoo](https://hub.docker.com/_/odoo)
  - Bitnami Odoo Docker image that can be found on Bitnami's website or again on hub.docker.com: [https://hub.docker.com/r/bitnami/odoo](https://hub.docker.com/r/bitnami/odoo)

## 1. Maunual Install 

Odoo needs a PostgreSQL server to run properly. Make sure that the sudo command is available and well configured and, only then, execute the following command in order to install the PostgreSQL server:

```sh
$ sudo dnf install -y postgresql-server
$ sudo postgresql-setup --initdb --unit postgresql
$ sudo systemctl enable postgresql
$ sudo systemctl start postgresql
```

### Warning

wkhtmltopdf is not installed through pip and must be installed manually in version 0.12.5 for it to support headers and footers. See our wiki for more details on the various versions.

### Repository

Odoo S.A. provides a repository that can be used with the Fedora distributions. It can be used to install Odoo Community Edition by executing the following commands:

```sh
sudo dnf config-manager --add-repo=https://nightly.odoo.com/15.0/nightly/rpm/odoo.repo
sudo dnf install -y odoo
sudo systemctl enable odoo
sudo systemctl start odoo
```

### RPM package

Instead of using the repository as described above, the ‘rpm’ packages for both the Community and Enterprise editions can be downloaded from the official download page.

Once downloaded, the package can be installed using the ‘dnf’ package manager:

```sh
sudo dnf localinstall odoo_15.0.latest.noarch.rpm
sudo systemctl enable odoo
sudo systemctl start odoo
```

### Source Install

The source `installation` is really about not installing Odoo, and running it directly from source instead.

This can be more convenient for module developers as the Odoo source is more easily accessible than using packaged installation (for information or to build this documentation and have it available offline).

It also makes starting and stopping Odoo more flexible and explicit than the services set up by the packaged installations, and allows overriding settings using command-line parameters without needing to edit a configuration file.

Finally it provides greater control over the system’s set up, and allows to more easily keep (and run) multiple versions of Odoo side-by-side.

## 2. Docker Install

The docker installation is easiest to be done and manage afterwards if you use a tool like Portainer or Rancher or Simular.

I'll be using Portainer

### Using Portainer

- Open Portainer
- Add Stack
- Give the stack it a name, i'll just call it `odoo`
- In the Docker Compose field paste the following YML (I'm using the Bitnami YML compose example, when I'm writing this there are no official YML docker compose example available)

```yml
version: '2'
services:
  postgresql:
    image: docker.io/bitnami/postgresql:13
    volumes:
      - 'postgresql_data:/bitnami/postgresql'
    environment:
      # ALLOW_EMPTY_PASSWORD is recommended only for development.
      - ALLOW_EMPTY_PASSWORD=yes
      - POSTGRESQL_USERNAME=bn_odoo
      - POSTGRESQL_DATABASE=bitnami_odoo
  odoo:
    image: docker.io/bitnami/odoo:15
    ports:
      - '80:8069'
      
    volumes:
      - 'odoo_data:/bitnami/odoo'
    depends_on:
      - postgresql
    environment:
      # DATABASE DETAILS
      # ALLOW_EMPTY_PASSWORD is recommended only for development.
      - ALLOW_EMPTY_PASSWORD=yes
      - ODOO_DATABASE_HOST=postgresql
      - ODOO_DATABASE_PORT_NUMBER=5432
      - ODOO_DATABASE_USER=bn_odoo
      - ODOO_DATABASE_NAME=bitnami_odoo
      # EMAIL (SMTP DETAILS) 
      - ODOO_SMTP_HOST=smtp.gmail.com
      - ODOO_SMTP_PORT_NUMBER=587
      - ODOO_SMTP_USER=your_email@gmail.com
      - ODOO_SMTP_PASSWORD=your_password
volumes:
  postgresql_data:
    driver: local
  odoo_data:
    driver: local
```

I am using NginX Proxy Manager that redirects anything that comes to port 80 to any other port. So I changed the line that said `- '80:8069'` to `- '8069:8069'`. Then I added a sub-domain: `odoo.example.com` and added a new proxy host to my proxy manager sending all traffic that hits that sub-domain to port 8069. Then I also added a SSL certificate with NginX proxy manager.

Thats it.


