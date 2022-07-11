# PHP Tasks

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