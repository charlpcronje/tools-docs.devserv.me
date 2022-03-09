# PHP Tasks

Tasks managed by PHP

Run the following command

```sh
cd /var/www/[folder]
git clone git://github.com/littleguga/tasks.php.git .
```

Add Virtual Host

```conf
# tasks.devserv.me
<VirtualHost 104.192.7.185:8080>
    ServerName tasks.devserv.me
    ServerAdmin admin@devserv.me
    DocumentRoot /var/www/tools/tasks.devserv.me/public
    <Directory /var/www/tools/tasks.devserv.me/public>
	    Require all granted
        Options +Indexes +FollowSymLinks
        AllowOverride All
    </Directory>
    ErrorLog /var/www/tools/tasks.devserv.me/logs/error.log
    CustomLog /var/www/tools/tasks.devserv.me/logs/access.log combined
</VirtualHost>
```

Restart httpd