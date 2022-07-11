---
order: 9
title: Install Vikunja TODO API
---
<script type="text/javascript">(function(w,s){var e=document.createElement("script");e.type="text/javascript";e.async=true;e.src="https://cdn.pagesense.io/js/webally/f2527eebee974243853bcd47b32631f4.js";var x=document.getElementsByTagName("script")[0];x.parentNode.insertBefore(e,x);})(window,"script");</script>

I tried using the docker image but CORS is giving me issus and I can't seem to get the docker image to read the config file in the location as specified in the documentation

## Installing from Binary

- Got to `https://dl.vikunja.io/api/` and open the latest version
- Right click on the binary that is appilicable for your OS and click op copy link address
- In my case that was `https://dl.vikunja.io/api/0.18.1/vikunja-unstable-x86_64.rpm`

```sh
cd /var/www/tools/doapi.CRONje.ME
wget https://dl.vikunja.io/api/0.18.1/vikunja-unstable-x86_64.rpm
rpm -i vikunja-unstable-x86_64.rpm
chmod +x /opt/vikunja
ln -s /opt/vikunja/vikunja /usr/bin/vikunja
```

## Create new service

- Save the following service file to /etc/systemd/system/vikunja.service and adapt it to your needs:
- In my case I am using MariaDB so I uncommented the line `Requires=mariadb.service`
```service
[Unit]
Description=Vikunja
After=syslog.target
After=network.target
# Depending on how you configured Vikunja, you may want to uncomment these:
#Requires=mysql.service
Requires=mariadb.service
#Requires=postgresql.service
#Requires=redis.service

[Service]
RestartSec=2s
Type=simple
WorkingDirectory=/opt/vikunja
ExecStart=/usr/bin/vikunja
Restart=always
# If you want to bind Vikunja to a port below 1024 uncomment
# the two values below
###
#CapabilityBoundingSet=CAP_NET_BIND_SERVICE
#AmbientCapabilities=CAP_NET_BIND_SERVICE

[Install]
WantedBy=multi-user.target
```

- If you’ve installed Vikunja to a directory other than /opt/vikunja, you need to adapt WorkingDirectory accordingly.
- After you made all nessecary modifications, it’s time to start the service:

```sh
sudo systemctl enable vikunja
sudo systemctl start vikunja
```

- This will start the servicec on port `3456`
- I use NginX Proxy Manager to direct traffic to port `3456` when I browse to `doapi.CRONje.ME`

Next Step: Install the [Frontend](vikunjaFrontend.md)

