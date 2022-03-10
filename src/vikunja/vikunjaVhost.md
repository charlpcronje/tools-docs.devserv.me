# Setup Virtual Host

Apache needs to have `mod_rewrite` enabled for this to work properly:

Add the following in httpd.conf at the end of the file or where ever you configure your virtual hosts

```conf
<VirtualHost 104.192.7.185:8080>
    ServerName do.devserv.me
    DocumentRoot /var/www/tools/do.devserv.me
    RewriteEngine On
 	RewriteRule ^\/?(fav
    RewriteRule ^(.*)$ /index.html [QSA,L]
    <Directory /var/www/tools/do.devserv.me>
	    Require all granted
        Options +Indexes +FollowSymLinks
        AllowOverride All
    </Directory>
    
    # If you want custom log files
    ErrorLog /var/www/tools/do.devserv.me/logs/error.log
    CustomLog /var/www/tools/do.devserv.me/logs/access.log combined
</VirtualHost>
```

- Remember to go and create the `logs` dir
- You probably want to adjust ServerName and DocumentRoot.
- Restart Apache

Next Step: Configure Fontend [Configure Frontend](vikunjaConfigureFrontend.md)