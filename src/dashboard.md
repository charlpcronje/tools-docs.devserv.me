# Dashboard

- Dashboard is one of the Awesome Selfhosted Dashboard apps listed
- I am already Using Heimdall and Organizir.
- Heimdall is limited to the amount of links you can show per page and you can't really cateogrize anything. Organizer don't have a simplistc bookmarks page so I'm planing to use dasboard a tab inside Organizer.

## Install

- I'm using [Portainer](https://setup.docs.CRONje.ME/portainer/) for installing dashboard in a container.
- Open Portainer
- Click on Stacks
- Click on Add Stack
- Give it a Name
- Add the following to the Docker Compose Field

```yml
version: "3"

services:
  dashboard:
    image: phntxx/dashboard:latest
    restart: unless-stopped
    environment:
      - CLOUDFLARE_ZONE_ID=[OPTIONAL CLOUDFLARE V4 ZONE ID]
      - CLOUDFLARE_PURGE_TOKEN=[OPTIONAL CLOUDFLARE PURGE TOKEN]
    volumes:
      - [path to store dashbboard data]:/app/data
    ports:
      - [port]:8080
```

- Click on `Deploy the stack`

## Failed to work

> Okay so after I followed my own steps above I kept on getting `JS` erors. Without time to fix it I decided to clone the repo and build it from source and host the dashboard with my existing apache server and use [NginX Proxy Manager](https://setup.docs.CRONje.ME/nginxproxymanager) to point [dashboard.CRONje.ME](https://dashboard.CRONje.ME) to the folder I cloned the repo to.

## Here are the steps I followed

```sh
cd /var/www/tools
git clone https://github.com/phntxx/dashboard.git
cd dashboard/
yarn
yarn build
cp -R build/* .
```

## Add host to proxy manager

- Open `NginX Proxy Manager`
- Add Proxy Host
- Complete Form
- Add Host

## Add Virtual Host

- Add Virtual Host to `httpd.conf` file or to whichever config file you are using for adding vhosts
- I added the following line to my `/etc/httpd/httpd.conf` file

```conf
# last line of: /etc/httpd/httpd.conf
IncludeOptional /var/www/**/*vhosts.conf
```

- The above will let apache look for `*vhosts.conf` in each sub-folder of `/var/www/`
- So for all my online tools `/var/www/tools/` there are a `vhosts.conf` file that contains all the vhost entries related to the `/var/www/tools` folder
- In the html folder there there I also created a `vhosts.conf` file etc.
- The reason I didn't make it `/var/www/**/vhosts.conf` but `/var/www/**/*vhosts.conf` with the `*` is otherwize apache requires a vhosts.conf file in each sub-folder instread of it being optional

- My Virtual Host entry for the dashboard

```conf
# dashboard.CRONje.ME
<VirtualHost 104.192.7.185:8080>
    ServerName dashboard.CRONje.ME
    ServerAdmin admin@CRONje.ME
    DocumentRoot /var/www/tools/dashboard.CRONje.ME/build
    <Directory /var/www/tools/dashboard.CRONje.ME/build>
    Require all granted
        Options +Indexes +FollowSymLinks
        AllowOverride All
    </Directory>
    ErrorLog /var/www/tools/dashboard.CRONje.ME/logs/error.log
    CustomLog /var/www/tools/dashboard.CRONje.ME/logs/access.log combined
</VirtualHost>
```

Then don't forget to restart apache

```sh
systemctl restart httpd
```
