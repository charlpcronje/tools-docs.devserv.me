---
title: PHP Tasks
---
<script type="text/javascript">(function(w,s){var e=document.createElement("script");e.type="text/javascript";e.async=true;e.src="https://cdn.pagesense.io/js/webally/f2527eebee974243853bcd47b32631f4.js";var x=document.getElementsByTagName("script")[0];x.parentNode.insertBefore(e,x);})(window,"script");</script>

Tasks managed by PHP

Run the following command

```sh
cd /var/www/[folder]
git clone git://github.com/littleguga/tasks.php.git .
```

Add Virtual Host

```conf
# tasks.CRONje.ME
<VirtualHost 104.192.7.185:8080>
    ServerName tasks.CRONje.ME
    ServerAdmin admin@CRONje.ME
    DocumentRoot /var/www/tools/tasks.CRONje.ME/public
    <Directory /var/www/tools/tasks.CRONje.ME/public>
	    Require all granted
        Options +Indexes +FollowSymLinks
        AllowOverride All
    </Directory>
    ErrorLog /var/www/tools/tasks.CRONje.ME/logs/error.log
    CustomLog /var/www/tools/tasks.CRONje.ME/logs/access.log combined
</VirtualHost>
```

Restart httpd