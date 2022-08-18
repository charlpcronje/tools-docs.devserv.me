---
title: Install Mattermost | Binary
label: Mattermost Binary
---
<script type="text/javascript">(function(w,s){var e=document.createElement("script");e.type="text/javascript";e.async=true;e.src="https://cdn.pagesense.io/js/webally/f2527eebee974243853bcd47b32631f4.js";var x=document.getElementsByTagName("script")[0];x.parentNode.insertBefore(e,x);})(window,"script");</script>

---
created: 2022-08-18T06:37:28 (UTC +02:00)
tags: []
source: https://docs.mattermost.com/install/install-rhel-8.html
author: 
---

# Install Mattermost on RHEL 8 

> ## Excerpt
> 

---
# [Install Mattermost on RHEL 8](https://docs.mattermost.com/install/install-rhel-8.html#id1) [](https://docs.mattermost.com/install/install-rhel-8.html#install-mattermost-on-rhel-8 "Permalink to this headline")

[![Available in Mattermost Free and Starter subscription plans.](https://docs.mattermost.com/install/install-rhel-8.html../_images/all-plans-badge.png)](https://mattermost.com/pricing) [![Available for Mattermost Self-Hosted deployments.](https://docs.mattermost.com/install/install-rhel-8.html../_images/self-hosted-badge.png)](https://mattermost.com/deploy)

You can also use these instructions to install Mattermost on CentOS 8 or Oracle Linux 8. With the exception of the operating system that you install, the process is identical.

A complete Mattermost installation consists of three major components: a proxy server, a database server, and the Mattermost server. You can install all components on one machine, or you can install each component on its own machine. If you have only two machines, then install the proxy and the Mattermost server on one machine, and install the database on the other machine.

For the database, you can install either MySQL or PostgreSQL. The proxy is NGINX.

Note

If you have any problems installing Mattermost, see the [troubleshooting guide](https://docs.mattermost.com/install/troubleshooting.html), or [join the Mattermost user community for troubleshooting help](https://mattermost.com/pl/default-ask-mattermost-community/).

For help with inviting users to your system, see [inviting team members](https://docs.mattermost.com/channels/manage-channel-members.html) and other [getting started information](https://docs.mattermost.com/getting-started/admin-onboarding-tasks.html#getting-started-tasks).

To submit an improvement or correction to this page, select **Edit** in the top-right corner of the page.

Install and configure the components in the following order.

-   [Install Mattermost on RHEL 8](https://docs.mattermost.com/install/install-rhel-8.html#install-mattermost-on-rhel-8)
    
    -   [Install Red Hat Enterprise Linux 8](https://docs.mattermost.com/install/install-rhel-8.html#install-red-hat-enterprise-linux-8)
        
    -   [Install a database](https://docs.mattermost.com/install/install-rhel-8.html#install-a-database)
        
    -   [Install Mattermost server](https://docs.mattermost.com/install/install-rhel-8.html#install-mattermost-server)
        
    -   [Configure Mattermost server](https://docs.mattermost.com/install/install-rhel-8.html#configure-mattermost-server)
        
    -   [Configure TLS on Mattermost server](https://docs.mattermost.com/install/install-rhel-8.html#configure-tls-on-mattermost-server)
        
    -   [Install NGINX server](https://docs.mattermost.com/install/install-rhel-8.html#install-nginx-server)
        
    -   [Configure NGINX as a proxy for Mattermost server](https://docs.mattermost.com/install/install-rhel-8.html#configure-nginx-as-a-proxy-for-mattermost-server)
        
    -   [Configure NGINX with SSL and HTTP/2](https://docs.mattermost.com/install/install-rhel-8.html#configure-nginx-with-ssl-and-http-2)
        

## [Install Red Hat Enterprise Linux 8](https://docs.mattermost.com/install/install-rhel-8.html#id2) [](https://docs.mattermost.com/install/install-rhel-8.html#install-red-hat-enterprise-linux-8 "Permalink to this headline")

Install the 64-bit version of RHEL 8 on each machine that hosts one or more of the components.

**To install RHEL 8 Server:**

1.  To install RHEL 8, see the [RedHat Installation Instructions](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/performing_a_standard_rhel_installation/index).
    
2.  After the system is installed, make sure that it’s up to date with the most recent security patches. Open a terminal window and issue the following commands:
    

> `sudo yum update`
> 
> `sudo yum upgrade`

Now that the system is up to date, you can start installing the components that make up a Mattermost system.

Note

Ensure that the `mailcap` package is installed as it includes the `mime.types` file which is needed for the Mobile App to work correctly.

## [Install a database](https://docs.mattermost.com/install/install-rhel-8.html#id3) [](https://docs.mattermost.com/install/install-rhel-8.html#install-a-database "Permalink to this headline")

Note

You only need one database: either MySQL or PostgreSQL. See the [database software](https://docs.mattermost.com/install/software-hardware-requirements.html#database-software) documentation for details on database version support.

Install MySQLInstall PostgreSQL

Install and set up a MySQL database for use by the Mattermost server.

1.  Log in to the server that will host the database, and open a terminal window.
    
2.  Install MySQL.
    
3.  Download and install the latest release package.
    
4.  Disable the system MySQL by running `sudo yum module disable mysql`, and install MySQL by running `sudo yum install mysql-community-server`.
    
5.  Start the MySQL server by running `sudo systemctl start mysqld.service`.
    
    > Note
    > 
    > The first time that you start MySQL:
    > 
    > -   The superuser account `'root'@'localhost'` is created with a password. Get this password by running `sudo grep 'temporary password' /var/log/mysqld.log`.
    >     
    > -   The `validate_password` plugin is installed. The plugin forces passwords to contain at least one upper case letter, one lower case letter, one digit, and one special character, and that the total password length is at least eight characters.
    >     
    
6.  Change the root password.
    
7.  Set MySQL to start automatically when the machine starts by running `sudo systemctl enable mysqld`.
    
8.  Create the Mattermost user _mmuser_ by running `mysql> create user 'mmuser'@'%' identified by 'mmuser-password';`.
    
    > Note
    > 
    > -   Use a password that’s more secure than `mmuser-password`.
    >     
    > -   The `%` means that mmuser can connect from any machine on the network. However, it’s more secure to use the IP address of the machine that hosts Mattermost. For example, if you install Mattermost on the machine with IP address `10.10.10.2`, then use the following command: `mysql> create user 'mmuser'@'10.10.10.2' identified by 'mmuser-password';`.
    >     
    
9.  Create the Mattermost database by running `mysql> create database mattermost;`.
    
10.  Grant access privileges to the user mmuser by running `mysql> grant all privileges on mattermost.* to 'mmuser'@'%';`.
    
    Note
    
    This query grants the MySQL user all privileges on the database for convenience. If you need more security, you can use the following query to grant the user only the privileges necessary to run Mattermost: `mysql> GRANT ALTER, CREATE, DELETE, DROP, INDEX, INSERT, SELECT, UPDATE, REFERENCES ON mattermost.* TO 'mmuser'@'%';`.
    
11.  Log out of MySQL by running `mysql> exit`.
    

With the database installed and the initial setup complete, you can now install the Mattermost server.

Install and set up a PostgreSQL database for use by the Mattermost server.

1.  Log in to the server that will host the database, and open a terminal window.
    
2.  Install PostgreSQL. See the [PostgreSQL](https://www.postgresql.org/download/linux/redhat/) documentation for details.
    
3.  Initialize the database by running `sudo postgresql-setup initdb`.
    
4.  Set PostgreSQL to start on boot by running `sudo systemctl enable postgresql`.
    
5.  Start the PostgreSQL server by running `sudo systemctl start postgresql`.
    
6.  Switch to the _postgres_ Linux user account that was created during the installation by running `sudo -iu postgres`.
    
7.  Start the PostgreSQL interactive terminal by running `psql`.
    
8.  Create the Mattermost database by running `postgres=# CREATE DATABASE mattermost WITH ENCODING 'UTF8' LC_COLLATE='en_US.UTF-8' LC_CTYPE='en_US.UTF-8' TEMPLATE=template0;`.
    
9.  Create the Mattermost user _mmuser_ by running `postgres=# CREATE USER mmuser WITH PASSWORD 'mmuser-password';`.
    
    Note
    
    Use a password that is more secure than `mmuser-password`.
    
10.  Grant the user access to the Mattermost database by running `postgres=# GRANT ALL PRIVILEGES ON DATABASE mattermost to mmuser;`.
    
11.  Exit the PostgreSQL interactive terminal by running `postgres=# \q`.
    
12.  Log out of the _postgres_ account by running `exit`.
    
13.  (Optional) If you use separate servers for your database and the Mattermost app server, you may allow PostgreSQL to listen on all assigned IP Addresses. To do so, open `/etc/postgresql/{version}/main/postgresql.conf` as _root_ in a text editor, and replacing `{version}` with the version of PostgreSQL that’s currently running. As a best practice, ensure that only the Mattermost server is able to connect to the PostgreSQL port using a firewall.
    
    1.  Open `/var/lib/pgsql/data/postgresql.conf` as root in a text editor.
        
    2.  Find the following line: `#listen_addresses = 'localhost'`.
        
    3.  Uncomment the line and change `localhost` to `*`: `listen_addresses = '*'`.
        
    4.  Restart PostgreSQL for the change to take effect: `sudo systemctl restart postgresql`.
        
14.  Modify the file `pg_hba.conf` to allow the Mattermost server to communicate with the database.
    
    **If the Mattermost server and the database are on the same machine:**
    
    > 1.  Open `/var/lib/pgsql/data/pg_hba.conf` as root in a text editor.
    >     
    > 2.  Find the following lines:
    >     
    > 
    > > `local   all             all                        peer`
    > > 
    > > `host    all             all         ::1/128        ident`
    > 
    > 3.  Change `peer` and `ident` to `trust`:
    >     
    > 
    > > `local   all             all                        trust`
    > > 
    > > `host    all             all         ::1/128        trust`
    
    **If the Mattermost server and the database are on different machines:**
    
    > 1.  Open `/var/lib/pgsql/data/pg_hba.conf` as _root_ in a text editor.
    >     
    > 2.  Add the following line to the end of the file, where _{mattermost-server-IP}_ is the IP address of the machine that contains the Mattermost server: `host all all {mattermost-server-IP}/32 md5`.
    >     
    
15.  Reload PostgreSQL by running `sudo systemctl reload postgresql`.
    
16.  Verify that you can connect with the user _mmuser_.
    
    1.  If the Mattermost server and the database are on the same machine, use the following command: `psql --dbname=mattermost --username=mmuser --password`.
        
    2.  If the Mattermost server is on a different machine, log into that machine and use the following command: `psql --host={postgres-server-IP} --dbname=mattermost --username=mmuser --password`.
        
    
    Note
    
    You might have to install the PostgreSQL client software to use the command.
    

The PostgreSQL interactive terminal starts. To exit the PostgreSQL interactive terminal, type `\q` and press **Enter**.

With the database installed and the initial setup complete, you can now install the Mattermost server.

## [Install Mattermost server](https://docs.mattermost.com/install/install-rhel-8.html#id4) [](https://docs.mattermost.com/install/install-rhel-8.html#install-mattermost-server "Permalink to this headline")

Install Mattermost Server on a 64-bit machine. Assume that the IP address of this server is `10.10.10.2`.

1.  Log in to the server that will host Mattermost Server and open a terminal window.
    
2.  Download [the latest version of the Mattermost Server](https://mattermost.com/deploy/). In the following command, replace `X.X.X` with the version that you want to download:
    

> `wget https://releases.mattermost.com/X.X.X/mattermost-X.X.X-linux-amd64.tar.gz`

3.  Extract the Mattermost Server files.
    

> `tar -xvzf *.gz`

4.  Move the extracted file to the `/opt` directory.
    

> `sudo mv mattermost /opt`

5.  Create the storage directory for files.
    

> `sudo mkdir /opt/mattermost/data`

Note

The storage directory will contain all the files and images that your users post to Mattermost, so you need to make sure that the drive is large enough to hold the anticipated number of uploaded files and images.

6.  Set up a system user and group called `mattermost` that will run this service, and set the ownership and permissions.
    

> 1.  `sudo useradd --system --user-group mattermost`
>     
> 2.  `sudo chown -R mattermost:mattermost /opt/mattermost`
>     
> 3.  `sudo chmod -R g+w /opt/mattermost`
>     
> 4.  `sudo restorecon -R /opt/mattermost`
>     

7.  Set up the database driver in the file `/opt/mattermost/config/config.json`. Open the file as _root_ in a text editor and make the following changes:
    

> -   If you are using PostgreSQL:
>     
> 
> > 1.  Set `"DriverName"` to `"postgres"`
> >     
> > 2.  Set `"DataSource"` to the following value, replacing `<mmuser-password>` and `<host-name-or-IP>` with the appropriate values:
> >     
> > 
> > > `"postgres://mmuser:<mmuser-password>@<host-name-or-IP>:5432/mattermost?sslmode=disable&connect_timeout=10"`.
> 
> -   If you are using MySQL:
>     
> 
> > 1.  Set `"DriverName"` to `"mysql"`
> >     
> > 2.  Set `"DataSource"` to the following value, replacing `<mmuser-password>` and `<host-name-or-IP>` with the appropriate values. Also make sure that the database name is `mattermost` instead of `mattermost_test`:
> >     
> > 
> > > `"mmuser:<mmuser-password>@tcp(<host-name-or-IP>:3306)/mattermost?charset=utf8mb4,utf8&writeTimeout=30s"`
> > 
> > Note
> > 
> > For a same-machine installation, replace `<host-name-or-IP>` above with `localhost` or `127.0.0.1`.

8.  Also set `"SiteURL"` to the full base URL of the site (e.g. `"https://mattermost.example.com"`).
    
9.  Test the Mattermost server to make sure everything works.
    
    > 1.  Change to the `mattermost` directory:
    >     
    > 
    > > `cd /opt/mattermost`
    > 
    > 2.  Start the Mattermost server as the user _mattermost_:
    >     
    > 
    > > `sudo -u mattermost ./bin/mattermost`
    

> When the server starts, it shows some log information and the text `Server is listening on :8065`. You can stop the server by pressing pressing Ctrl C on Windows or Linux, or ⌘ C on Mac, in the terminal window.

10.  Set up Mattermost to use the `systemd init` daemon which handles supervision of the Mattermost process.
    

> 1.  Create the Mattermost configuration file:
>     
> 
> > `sudo touch /etc/systemd/system/mattermost.service`
> 
> 2.  Open the configuration file in a text editor, and copy the following lines into the file:
>     
> 
> > ```
> > [Unit]
> > Description=Mattermost
> > After=syslog.target network.target postgresql.service
> > 
> > [Service]
> > Type=notify
> > WorkingDirectory=/opt/mattermost
> > User=mattermost
> > ExecStart=/opt/mattermost/bin/mattermost
> > PIDFile=/var/spool/mattermost/pid/master.pid
> > TimeoutStartSec=3600
> > KillMode=mixed
> > LimitNOFILE=49152
> > 
> > [Install]
> > WantedBy=multi-user.target
> > 
> > ```
> > 
> > 
> > 
> > Note
> > 
> > If you are using MySQL, replace `postgresql.service` with `mysqld.service` in the `[unit]` section.
> 
> 3.  Set the service file permissions.
>     
> 
> > `sudo chmod 644 /etc/systemd/system/mattermost.service`
> 
> 4.  Reload the systemd services.
>     
> 
> > `sudo systemctl daemon-reload`
> 
> 5.  Set Mattermost to start on boot.
>     
> 
> > `sudo systemctl enable mattermost`

11.  Start the Mattermost server.
    

> `sudo systemctl start mattermost`

12.  Verify that Mattermost is running.
    

> `curl http://localhost:8065`
> 
> You should see the HTML that’s returned by the Mattermost server.

Now that Mattermost is installed and running, it’s time to create the admin user and configure Mattermost for use.

## [Configure Mattermost server](https://docs.mattermost.com/install/install-rhel-8.html#id5) [](https://docs.mattermost.com/install/install-rhel-8.html#configure-mattermost-server "Permalink to this headline")

Create the System Admin user and set up Mattermost for general use.

1.  Open a browser and navigate to your Mattermost instance. For example, if the IP address of the Mattermost server is `10.10.10.2` then go to [http://10.10.10.2:8065](http://10.10.10.2:8065).
    
2.  Create the first team and user. The first user in the system has the `system_admin` role, which gives you access to the System Console.
    
3.  To open the System Console, select the Product menu in the top-left corner of the navigation panel, then select **System Console**.
    
4.  Set the site URL:
    

> -   Open **System Console > Environment > Web Server**.
>     
> -   In the **Site URL** field, set the URL that users point their browsers at. For example, _https://mattermost.example.com_. If you’re using HTTPS, make sure that you set up TLS, either on Mattermost server or on a proxy.
>     

5.  Set up email notifications.
    

> -   In **Site Configuration > Notifications** make the following changes:
>     
>     -   Set **Enable Email Notifications** to **true**
>         
>     -   Set **Notification Display Name** to **No-Reply**
>         
>     -   Set **Notification From Address** to _{your-domain-name}_ For example, _example.com_
>         
> -   In **System Console > Environment > SMTP** make the following changes:
>     
>     -   Set **SMTP Server Username** to _{SMTP-username}_ For example, _admin@example.com_
>         
>     -   Set **SMTP Server Password** to _{SMTP-password}_
>         
>     -   Set **SMTP Server** to _{SMTP-server}_ For example, _mail.example.com_
>         
>     -   Set **SMTP Server Port** to _465_
>         
>     -   Set **Connection Security** to _TLS_ or _STARTTLS_, depending on what the SMTP server accepts
>         
> -   Select **Save**
>     
> -   Select **Test Connection**.
>     

6.  Open **System Console > Environment > File Storage** to set up the file and image storage location.
    

> -   If you store the files locally, set **File Storage System** to _Local File System_, and then either accept the default for the **Local Storage Directory** or enter a location. The location must be a directory that exists and has write permissions for the Mattermost server. It can be an absolute path or a relative path. Relative paths are relative to the `mattermost` directory.
>     
> -   If you store the files on Amazon S3, set **File Storage System** to _Amazon S3_ and enter the appropriate values for your Amazon account.
>     

Note

-   Files and images that users attach to their messages are not stored in the database. Instead, they’re stored in a location that you specify, such as the local file system or in Amazon S3.
    
-   Make sure that the location has enough free space. The amount of storage required depends on the number of users and the number and size of files that users attach to messages.
    

7.  Select **Save** to apply the configuration.
    
8.  Review and configure any other settings that may be applicable.
    
9.  Restart Mattermost by running `sudo systemctl restart mattermost`.
    

## [Configure TLS on Mattermost server](https://docs.mattermost.com/install/install-rhel-8.html#id6) [](https://docs.mattermost.com/install/install-rhel-8.html#configure-tls-on-mattermost-server "Permalink to this headline")

You have two options if you want users to connect with HTTPS:

> 1.  Set up TLS on Mattermost server.
>     
> 2.  Install a proxy such as NGINX and set up TLS on the proxy.
>     

The easiest option is to set up TLS on the Mattermost Server, but if you expect to have more than 200 users, use a proxy for better performance. A proxy server also provides standard HTTP request logs.

Note

Your Mattermost server must be accessible from the Let’s Encrypt CA in order to verify your domain name and issue the certificate. Be sure to open your firewall and configure any reverse proxies to forward traffic to ports 80 and 443. More information can be found [at Let’s Encrypt](https://letsencrypt.org/how-it-works/).

### Configure TLS on the Mattermost server [](https://docs.mattermost.com/install/install-rhel-8.html#configure-tls-on-the-mattermost-server "Permalink to this headline")

1.  In **System Console > Environment > Web Server** (or **System Console > General > Configuration** in versions prior to 5.12).
    

> 1.  Change the **Listen Address** setting to `:443`.
>     
> 2.  Change the **Connection Security** setting to `TLS`.
>     
> 3.  Change the **Forward port 80 to 443** setting to `true`.
>     

2.  Activate the `CAP_NET_BIND_SERVICE` capability to allow Mattermost to bind to low ports.
    

> `sudo setcap cap_net_bind_service=+ep /opt/mattermost/bin/mattermost`

3.  Install the security certificate. You can use [Let’s Encrypt](https://letsencrypt.org/) to automatically install and setup the certificate, or you can specify your own certificate.
    

### To use a Let’s Encrypt certificate [](https://docs.mattermost.com/install/install-rhel-8.html#to-use-a-let-s-encrypt-certificate "Permalink to this headline")

The certificate is retrieved the first time that a client tries to connect to the Mattermost server. Certificates are retrieved for any hostname a client tries to reach the server at.

> 1.  Change the **Use Let’s Encrypt** setting to `true`.
>     
> 2.  Restart the Mattermost server for these changes to take effect.
>     

Note

If Let’s Encrypt is enabled, forward port 80 through a firewall, with [Forward80To443](https://docs.mattermost.com/configure/configuration-settings.html#forward-port-80-to-443) `config.json` setting set to `true` to complete the Let’s Encrypt certification.

### To use your own certificate [](https://docs.mattermost.com/install/install-rhel-8.html#to-use-your-own-certificate "Permalink to this headline")

> 1.  Change the **Use Let’s Encrypt** setting to `false`.
>     
> 2.  Change the **TLS Certificate File** setting to the location of the certificate file.
>     
> 3.  Change the **TLS Key File** setting to the location of the private key file.
>     
> 4.  Restart the Mattermost server for these changes to take effect.
>     

Note

Password-protected certificates are not supported.

### Use TLS on NGINX (as a proxy) [](https://docs.mattermost.com/install/install-rhel-8.html#use-tls-on-nginx-as-a-proxy "Permalink to this headline")

Note

Do not set up TLS on Mattermost before before doing so for NGINX. It breaks the connection as the TLS prevents it from successfully communicating with the Mattermost server.

-   NGINX will act as a forward proxy to encrypt the traffic between the client and Mattermost server. After installing the SSL certificate, the incoming traffic will be handled via NGINX on port 443 exposed to the internet, proxy to the Mattermost server running on port 80.
    
-   (Optional) Upstream encryption between NGINX to Mattermost server is allowed.
    
-   Follow [NGINX’s guide on setting up SSL Termination for TCP Upstream Servers](https://docs.nginx.com/nginx/admin-guide/security-controls/terminating-ssl-tcp/).
    

Other helpful resources:

-   [NGINX’s SSL blog](https://www.nginx.com/blog/nginx-ssl/)
    
-   [NGINX’s SSL guide](https://docs.nginx.com/nginx/admin-guide/security-controls/terminating-ssl-http/)
    

## [Install NGINX server](https://docs.mattermost.com/install/install-rhel-8.html#id7) [](https://docs.mattermost.com/install/install-rhel-8.html#install-nginx-server "Permalink to this headline")

In a production setting, use a proxy server for greater security and performance of Mattermost:

> -   SSL termination
>     
> -   HTTP to HTTPS redirect
>     
> -   Port mapping `:80` to `:8065`
>     
> -   Standard request logs
>     

1.  Log in to the server that will host the proxy, and open a terminal window.
    
2.  Create the file `/etc/yum.repos.d/nginx.repo` by running `sudo touch /etc/yum.repos.d/nginx.repo`.
    

> If you are on RHEL 8 you can skip to **Step 4. Install NGINX**.

3.  Open the file as _root_ in a text editor and add the following contents, where _{version}_ is **7** for RHEL 7:
    

> ```
> [nginx]
> name=nginx repo
> baseurl=https://nginx.org/packages/rhel/{version}/$basearch/
> gpgcheck=0
> enabled=1
> 
> ```
> 

4.  Install NGINX by running `sudo yum install nginx.x86_64`.
    
5.  After the installation is complete, start NGINX by running `sudo systemctl start nginx`.
    
    On RHEL 6:
    
6.  **Optional** Set NGINX to start at system boot by running `sudo systemctl enable nginx`.
    
7.  Verify that NGINX is running by running `curl http://localhost`.
    

> If NGINX is running, you see the following output:
> 
> ```
> <!DOCTYPE html>
> <html>
> <head>
> <title>Welcome to nginx!</title>
> .
> .
> .
> <p><em>Thank you for using nginx.</em></p>
> </body>
> </html>
> 
> ```
> 

**What to do next**

1.  Map a fully qualified domain name (FQDN) such as `mattermost.example.com` to point to the NGINX server.
    
2.  Configure NGINX to proxy connections from the Internet to the Mattermost Server.
    

## [Configure NGINX as a proxy for Mattermost server](https://docs.mattermost.com/install/install-rhel-8.html#id8) [](https://docs.mattermost.com/install/install-rhel-8.html#configure-nginx-as-a-proxy-for-mattermost-server "Permalink to this headline")

NGINX is configured using a file in the `/etc/nginx/sites-available` directory. You need to create the file and then enable it. When creating the file, you need the IP address of your Mattermost server and the fully qualified domain name (FQDN) of your Mattermost website.

1.  Log in to the server that hosts NGINX and open a terminal window.
    
2.  Create a configuration file for Mattermost by running
    

> `sudo touch /etc/nginx/sites-available/mattermost` on Ubuntu `sudo touch /etc/nginx/conf.d/mattermost` on RHEL 8

3.  Open the file `/etc/nginx/sites-available/mattermost` (Ubuntu) or `/etc/nginx/conf.d/mattermost` (RHEL 8) as _root_ user in a text editor and replace its contents, if any, with the following lines. Make sure that you use your own values for the Mattermost server IP address and FQDN for _server\_name_.
    

SSL and HTTP/2 with server push are enabled in the provided configuration example.

> Note
> 
> -   If you’re going to use Let’s Encrypt to manage your SSL certificate, stop at step 3 and see the [NGINX HTTP/2 and SSL product documentation](https://docs.mattermost.com/install/config-ssl-http2-nginx.html) for details.
>     
> -   You’ll need valid SSL certificates in order for NGINX to pin the certificates properly. Additionally, your browser must have permissions to accept the certificate as a valid CA-signed certificate.
>     
> -   Note that the IP address included in the examples in this documentation may not match your network configuration.
>     
> -   If you’re running NGINX on the same machine as Mattermost, and NGINX resolves `localhost` to more than one IP address (IPv4 or IPv6), we recommend using `127.0.0.1` instead of `localhost`.
>     
> 
> ```
> upstream backend {
>    server 10.10.10.2:8065;
>    keepalive 32;
> }
> 
> proxy_cache_path /var/cache/nginx levels=1:2 keys_zone=mattermost_cache:10m max_size=3g inactive=120m use_temp_path=off;
> 
> server {
>   listen 80 default_server;
>   server_name   mattermost.example.com;
>   return 301 https://$server_name$request_uri;
> }
> 
> server {
>    listen 443 ssl http2;
>    server_name    mattermost.example.com;
> 
>    http2_push_preload on; # Enable HTTP/2 Server Push
> 
>    ssl on;
>    ssl_certificate /etc/letsencrypt/live/{domain-name}/fullchain.pem;
>    ssl_certificate_key /etc/letsencrypt/live/{domain-name}/privkey.pem;
>    ssl_session_timeout 1d;
> 
>    # Enable TLS versions (TLSv1.3 is required upcoming HTTP/3 QUIC).
>    ssl_protocols TLSv1.2 TLSv1.3;
> 
>    # Enable TLSv1.3's 0-RTT. Use $ssl_early_data when reverse proxying to
>    # prevent replay attacks.
>    #
>    # @see: https://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_early_data
>    ssl_early_data on;
> 
>    ssl_ciphers 'ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384';
>    ssl_prefer_server_ciphers on;
>    ssl_session_cache shared:SSL:50m;
>    # HSTS (ngx_http_headers_module is required) (15768000 seconds = six months)
>    add_header Strict-Transport-Security max-age=15768000;
>    # OCSP Stapling ---
>    # fetch OCSP records from URL in ssl_certificate and cache them
>    ssl_stapling on;
>    ssl_stapling_verify on;
> 
>    add_header X-Early-Data $tls1_3_early_data;
> 
>    location ~ /api/v[0-9]+/(users/)?websocket$ {
>        proxy_set_header Upgrade $http_upgrade;
>        proxy_set_header Connection "upgrade";
>        client_max_body_size 50M;
>        proxy_set_header Host $http_host;
>        proxy_set_header X-Real-IP $remote_addr;
>        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
>        proxy_set_header X-Forwarded-Proto $scheme;
>        proxy_set_header X-Frame-Options SAMEORIGIN;
>        proxy_buffers 256 16k;
>        proxy_buffer_size 16k;
>        client_body_timeout 60;
>        send_timeout 300;
>        lingering_timeout 5;
>        proxy_connect_timeout 90;
>        proxy_send_timeout 300;
>        proxy_read_timeout 90s;
>        proxy_http_version 1.1;
>        proxy_pass http://backend;
>    }
> 
>    location / {
>        client_max_body_size 50M;
>        proxy_set_header Connection "";
>        proxy_set_header Host $http_host;
>        proxy_set_header X-Real-IP $remote_addr;
>        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
>        proxy_set_header X-Forwarded-Proto $scheme;
>        proxy_set_header X-Frame-Options SAMEORIGIN;
>        proxy_buffers 256 16k;
>        proxy_buffer_size 16k;
>        proxy_read_timeout 600s;
>        proxy_cache mattermost_cache;
>        proxy_cache_revalidate on;
>        proxy_cache_min_uses 2;
>        proxy_cache_use_stale timeout;
>        proxy_cache_lock on;
>        proxy_http_version 1.1;
>        proxy_pass http://backend;
>    }
> }
> 
> # This block is useful for debugging TLS v1.3. Please feel free to remove this
> # and use the `$ssl_early_data` variable exposed by NGINX directly should you
> # wish to do so.
> map $ssl_early_data $tls1_3_early_data {
>   "~." $ssl_early_data;
>   default "";
> }
> 
> ```
> 

4.  Remove the existing default sites-enabled file by running `sudo rm /etc/nginx/sites-enabled/default` (Ubuntu) or `sudo rm /etc/nginx/conf.d/default` (RHEL 8)
    
5.  Enable the mattermost configuration by running `sudo ln -s /etc/nginx/sites-available/mattermost /etc/nginx/sites-enabled/mattermost` (Ubuntu) or `sudo ln -s /etc/nginx/conf.d/mattermost /etc/nginx/conf.d/default.conf` (RHEL 8)
    
6.  Restart NGINX by running `sudo systemctl restart nginx`.
    
7.  Verify that you can see Mattermost through the proxy by running `curl https://localhost`.
    

> If everything is working, you will see the HTML for the Mattermost signup page.

8.  Restrict access to port 8065.
    

> By default, the Mattermost server accepts connections on port 8065 from every machine on the network. Use your firewall to deny connections on port 8065 to all machines except the machine that hosts NGINX and the machine that you use to administer the Mattermost server. If you’re installing on Amazon Web Services, you can use Security Groups to restrict access.

Now that NGINX is installed and running, you can configure it to use SSL, which allows you to use HTTPS connections and the HTTP/2 protocol.

## [Configure NGINX with SSL and HTTP/2](https://docs.mattermost.com/install/install-rhel-8.html#id9) [](https://docs.mattermost.com/install/install-rhel-8.html#configure-nginx-with-ssl-and-http-2 "Permalink to this headline")

NGINX is configured using a file in the `/etc/nginx/sites-available` directory. You need to create the file and then enable it. When creating the file, you need the IP address of your Mattermost server and the fully qualified domain name (FQDN) of your Mattermost website.

Using SSL gives greater security by ensuring that communications between Mattermost clients and the Mattermost server are encrypted. It also allows you to configure NGINX to use the HTTP/2 protocol.

Although you can configure HTTP/2 without SSL, both Firefox and Chrome browsers support HTTP/2 on secure connections only.

You can use any certificate that you want, but these instructions show you how to download and install certificates from [Let’s Encrypt](https://letsencrypt.org/), a free certificate authority.

Note

If Let’s Encrypt is enabled, forward port 80 through a firewall, with [Forward80To443](https://docs.mattermost.com/configure/configuration-settings.html#forward-port-80-to-443) `config.json` setting set to `true` to complete the Let’s Encrypt certification. See the [Let’s Encrypt/Certbot documentation](https://certbot.eff.org) for additional assistance.

1.  Log in to the server that hosts NGINX and open a terminal window.
    
2.  Open the your Mattermost `nginx.conf` file as _root_ in a text editor, then update the `{ip}` address in the `upstream backend` to point towards Mattermost (such as `127.0.0.1:8065`), and update the `server_name` to be your domain for Mattermost.
    

> Note
> 
> -   On Ubuntu this file is located at `/etc/nginx/sites-available/`. If you don’t have this file, run `sudo touch /etc/nginx/sites-available/mattermost`.
>     
> -   On CentOS/RHEL this file is located at `/etc/nginx/conf.d/`. If you don’t have this file, run `sudo touch /etc/nginx/conf.d/mattermost`.
>     
> -   Note that the IP address included in the examples in this documentation may not match your network configuration.
>     
> -   If you’re running NGINX on the same machine as Mattermost, and NGINX resolves `localhost` to more than one IP address (IPv4 or IPv6), we recommend using `127.0.0.1` instead of `localhost`.
>     
> 
> ```
> upstream backend {
>     server {ip}:8065;
>     keepalive 32;
>     }
> 
> proxy_cache_path /var/cache/nginx levels=1:2 keys_zone=mattermost_cache:10m max_size=3g inactive=120m use_temp_path=off;
> 
> server {
>     listen 80 default_server;
>     server_name mattermost.example.com;
> 
>     location ~ /api/v[0-9]+/(users/)?websocket$ {
>         proxy_set_header Upgrade $http_upgrade;
>         proxy_set_header Connection "upgrade";
>         client_max_body_size 50M;
>         proxy_set_header Host $http_host;
>         proxy_set_header X-Real-IP $remote_addr;
>         proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
>         proxy_set_header X-Forwarded-Proto $scheme;
>         proxy_set_header X-Frame-Options SAMEORIGIN;
>         proxy_buffers 256 16k;
>         proxy_buffer_size 16k;
>         client_body_timeout 60;
>         send_timeout 300;
>         lingering_timeout 5;
>         proxy_connect_timeout 90;
>         proxy_send_timeout 300;
>         proxy_read_timeout 90s;
>         proxy_pass http://backend;
>     }
> 
>     location / {
>         client_max_body_size 50M;
>         proxy_set_header Connection "";
>         proxy_set_header Host $http_host;
>         proxy_set_header X-Real-IP $remote_addr;
>         proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
>         proxy_set_header X-Forwarded-Proto $scheme;
>         proxy_set_header X-Frame-Options SAMEORIGIN;
>         proxy_buffers 256 16k;
>         proxy_buffer_size 16k;
>         proxy_read_timeout 600s;
>         proxy_cache mattermost_cache;
>         proxy_cache_revalidate on;
>         proxy_cache_min_uses 2;
>         proxy_cache_use_stale timeout;
>         proxy_cache_lock on;
>         proxy_http_version 1.1;
>         proxy_pass http://backend;
>     }
> }
> 
> ```
> 

3.  Remove the existing default sites-enabled file by running `sudo rm /etc/nginx/sites-enabled/default` (Ubuntu) or `sudo rm /etc/nginx/conf.d/default` (RHEL 8).
    
4.  Enable the Mattermost configuration by running `sudo ln -s /etc/nginx/sites-available/mattermost /etc/nginx/sites-enabled/mattermost` (Ubuntu) or `sudo ln -s /etc/nginx/conf.d/mattermost /etc/nginx/conf.d/default.conf` (RHEL 8).
    
5.  Run `sudo nginx -t` to ensure your configuration is done properly. If you get an error, look into the NGINX config and make the needed changes to the file under `/etc/nginx/sites-available/mattermost`.
    
6.  Restart NGINX by running `sudo systemctl start nginx`.
    
7.  Verify that you can see Mattermost through the proxy by running `curl http://localhost`.
    

> If everything is working, you will see the HTML for the Mattermost signup page. You will see invalid certificate when accessing through the IP or localhost. Use the full FQDN domain to verify if the SSL certificate has pinned properly and is valid.

8.  Install and update Snap by running `sudo snap install core; sudo snap refresh core`.
    
9.  Install the Certbot package by running `sudo snap install --classic certbot`.
    
10.  Add a symbolic link to ensure Certbot can run by running `sudo ln -s /snap/bin/certbot /usr/bin/certbot`.
    
11.  Run the Let’s Encrypt installer dry-run to ensure your DNS is configured properly by running `sudo certbot certonly --dry-run`.
    

> This will prompt you to enter your email, accept the TOS, share your email, and select the domain you’re activating certbot for. This will validate that your DNS points to this server properly and you are able to successfully generate a certificate. If this finishes successfully, proceed to step 12.

12.  Run the Let’s Encrypt installer by running `sudo certbot`. This will run certbot and will automatically edit your NGINX config file for the site(s) selected.
    
13.  Ensure your SSL is configured properly by running `curl https://{your domain here}`
    
14.  Finally, we suggest editing your config file again to increase your SSL security settings above the default Let’s Encrypt. This is the same file from Step 2 above. Edit it to look like the below:
    

> ```
> upstream backend {
>     server {ip}:8065;
>    keepalive 32;
>     }
> 
> proxy_cache_path /var/cache/nginx levels=1:2 keys_zone=mattermost_cache:10m max_size=3g inactive=120m use_temp_path=off;
> 
> server {
>     server_name mattermost.example.com;
> 
>     location ~ /api/v[0-9]+/(users/)?websocket$ {
>         proxy_set_header Upgrade $http_upgrade;
>         proxy_set_header Connection "upgrade";
>         client_max_body_size 50M;
>         proxy_set_header Host $http_host;
>         proxy_set_header X-Real-IP $remote_addr;
>         proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
>         proxy_set_header X-Forwarded-Proto $scheme;
>         proxy_set_header X-Frame-Options SAMEORIGIN;
>         proxy_buffers 256 16k;
>         proxy_buffer_size 16k;
>         client_body_timeout 60;
>         send_timeout 300;
>         lingering_timeout 5;
>         proxy_connect_timeout 90;
>         proxy_send_timeout 300;
>         proxy_read_timeout 90s;
>         proxy_http_version 1.1;
>         proxy_pass http://backend;
>     }
> 
>     location / {
>         client_max_body_size 50M;
>         proxy_set_header Connection "";
>         proxy_set_header Host $http_host;
>         proxy_set_header X-Real-IP $remote_addr;
>         proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
>         proxy_set_header X-Forwarded-Proto $scheme;
>         proxy_set_header X-Frame-Options SAMEORIGIN;
>         proxy_buffers 256 16k;
>         proxy_buffer_size 16k;
>         proxy_read_timeout 600s;
>         proxy_cache mattermost_cache;
>         proxy_cache_revalidate on;
>         proxy_cache_min_uses 2;
>         proxy_cache_use_stale timeout;
>         proxy_cache_lock on;
>         proxy_http_version 1.1;
>         proxy_pass http://backend;
>     }
> 
>     listen 443 ssl http2; # managed by Certbot
>     ssl_certificate /etc/letsencrypt/live/mattermost.example.com/fullchain.pem; # managed by Certbot
>     ssl_certificate_key /etc/letsencrypt/live/mattermost.example.com/privkey.pem; # managed by Certbot
>     # include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
>     ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
> 
>     ssl_session_timeout 1d;
> 
>     # Enable TLS versions (TLSv1.3 is required upcoming HTTP/3 QUIC).
>     ssl_protocols TLSv1.2 TLSv1.3;
> 
>     # Enable TLSv1.3's 0-RTT. Use $ssl_early_data when reverse proxying to
>     # prevent replay attacks.
>     #
>     # @see: https://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_early_data
>     ssl_early_data on;
> 
>     ssl_ciphers ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES256-SHA;
>     ssl_prefer_server_ciphers on;
>     ssl_session_cache shared:SSL:50m;
>     # HSTS (ngx_http_headers_module is required) (15768000 seconds = six months)
>     add_header Strict-Transport-Security max-age=15768000;
>     # OCSP Stapling ---
>     # fetch OCSP records from URL in ssl_certificate and cache them
>     ssl_stapling on;
>     ssl_stapling_verify on;
> }
> 
> 
> server {
>     if ($host = mattermost.example.com) {
>         return 301 https://$host$request_uri;
>     } # managed by Certbot
> 
> 
>     listen 80 default_server;
>     server_name mattermost.example.com;
>     return 404; # managed by Certbot
> 
> }
> 
> ```
> 

15.  Check that your SSL certificate is set up correctly.
    

> -   Test the SSL certificate by visiting a site such as [https://www.ssllabs.com/ssltest/index.html](https://www.ssllabs.com/ssltest/index.html).
>     
> -   If there’s an error about the missing chain or certificate path, there is likely an intermediate certificate missing that needs to be included.
>     

### NGINX configuration FAQ [](https://docs.mattermost.com/install/install-rhel-8.html#nginx-configuration-faq "Permalink to this headline")

#### Why are Websocket connections returning a 403 error? [](https://docs.mattermost.com/install/install-rhel-8.html#why-are-websocket-connections-returning-a-403-error "Permalink to this headline")

This is likely due to a failing cross-origin check. A check is applied for WebSocket code to see if the `Origin` header is the same as the host header. If it’s not, a 403 error is returned. Open the file `/etc/nginx/sites-available/mattermost` as _root_ in a text editor and make sure that the host header being set in the proxy is dynamic:

```
location ~ /api/v[0-9]+/(users/)?websocket$ {
  proxy_pass            http://backend;
  (...)
  proxy_set_header      Host $host;
  proxy_set_header      X-Forwarded-For $remote_addr;
}

```

Then in `config.json` set the `AllowCorsFrom` setting to match the domain being used by clients. You may need to add variations of the host name that clients may send. Your NGINX log will be helpful in diagnosing the problem.

```
"EnableUserAccessTokens": false,
"AllowCorsFrom": "domain.com domain.com:443 im.domain.com",
"SessionLengthWebInDays": 30,

```

For other troubleshooting tips for WebSocket errors, see [potential solutions here](https://docs.mattermost.com/install/troubleshooting.html#please-check-connection-mattermost-unreachable-if-issue-persists-ask-administrator-to-check-websocket-port).

#### How do I setup an NGINX proxy with the Mattermost Docker installation? [](https://docs.mattermost.com/install/install-rhel-8.html#how-do-i-setup-an-nginx-proxy-with-the-mattermost-docker-installation "Permalink to this headline")

1.  Find the name of the Mattermost network and connect it to the NGINX proxy.
    

```
docker network ls
# Grep the name of your Mattermost network like "mymattermost_default".
docker network connect mymattermost_default nginx-proxy

```


2.  Restart the Mattermost Docker containers.
    

```
docker-compose stop app
docker-compose start app

```


Tip

You don’t need to run the ‘web’ container, since NGINX proxy accepts incoming requests.

3.  Update your `docker-compose.yml` file to include a new environment variable `VIRTUAL_HOST` and an `expose` directive.
    

```
environment:
  # set same as db credentials and dbname
  - MM_USERNAME=mmuser
  - MM_PASSWORD=mmuser-password
  - MM_DBNAME=mattermost
  - VIRTUAL_HOST=mymattermost.tld
expose:
  - "80"
  - "443"

```

#### Why does NGINX fail when installing Gitlab CE with Mattermost on Azure? [](https://docs.mattermost.com/install/install-rhel-8.html#why-does-nginx-fail-when-installing-gitlab-ce-with-mattermost-on-azure "Permalink to this headline")

You may need to update the Callback URLs for the Application entry of Mattermost inside your GitLab instance.

1.  Log in to your GitLab instance as the admin.
    
2.  Go to **Admin > Applications**.
    
3.  Select **Edit** on GitLab-Mattermost.
    
4.  Update the callback URLs to your new domain/URL.
    
5.  Save the changes.
    
6.  Update the external URL for GitLab and Mattermost in the `/etc/gitlab/gitlab.rb` configuration file.
    

#### Why does Certbot fail the http-01 challenge? [](https://docs.mattermost.com/install/install-rhel-8.html#why-does-certbot-fail-the-http-01-challenge "Permalink to this headline")

```
Requesting a certificate for yourdomain.com
Performing the following challenges:
http-01 challenge for yourdomain.com
Waiting for verification...
Challenge failed for domain yourdomain.com
http-01 challenge for yourdomain.com
Cleaning up challenges
Some challenges have failed.

```


If you see the above errors this is typically because Certbot wasn’t able to access port 80. This can be due to a firewall or other DNS configuration. Make sure that your A/AAAA records are pointing to this server and your `server_name` within the NGINX config doesn’t have a redirect.

Note

If you’re using Cloudflare you’ll need to disable `force traffic to https`.

#### Certbot rate limiting [](https://docs.mattermost.com/install/install-rhel-8.html#certbot-rate-limiting "Permalink to this headline")

If you’re running certbot as stand-alone you’ll see this error:

```
Error: Could not issue a Let's Encrypt SSL/TLS certificate for example.com.
One of the Let's Encrypt rate limits has been exceeded for example.com.
See the related Knowledge Base article for details.
Details
Invalid response from https://acme-v02.api.letsencrypt.org/acme/new-order.
Details:
Type: urn:ietf:params:acme:error:rateLimited
Status: 429
Detail: Error creating new order :: too many failed authorizations recently: see https://letsencrypt.org/docs/rate-limits/

```

If you’re running Let’s Encrypt within Mattermost you’ll see this error:

```
{"level":"error","ts":1609092001.752515,"caller":"http/server.go:3088","msg":"http: TLS handshake error from ip:port: 429 urn:ietf:params:acme:error:rateLimited: Error creating new order :: too many failed authorizations recently: see https://letsencrypt.org/docs/rate-limits/","source":"httpserver"}

```

This means that you’ve attempted to generate a cert too many times. You can find more information [here](https://letsencrypt.org/docs/rate-limits).

[Next](https://docs.mattermost.com/install/install-rhel-8.htmlinstall-centos-oracle-scientific.html "Installing Mattermost on CentOS, Oracle Linux, and Scientific Linux") [Previous](https://docs.mattermost.com/install/install-rhel-8.htmlinstall-debian.html "Installing Mattermost on Debian Buster")

___
