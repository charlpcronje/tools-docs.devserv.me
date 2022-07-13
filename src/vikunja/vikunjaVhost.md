---
order: 5
title: Setup Virtual Host
---
<script type="text/javascript">(function(w,s){var e=document.createElement("script");e.type="text/javascript";e.async=true;e.src="https://cdn.pagesense.io/js/webally/f2527eebee974243853bcd47b32631f4.js";var x=document.getElementsByTagName("script")[0];x.parentNode.insertBefore(e,x);})(window,"script");</script>

Apache needs to have `mod_rewrite` enabled for this to work properly:

Add the following in httpd.conf at the end of the file or where ever you configure your virtual hosts

```conf
<VirtualHost 104.192.7.185:8080>
    ServerName do.CRONje.ME
    DocumentRoot /var/www/tools/do.CRONje.ME
    RewriteEngine On
 	RewriteRule ^\/?(fav
    RewriteRule ^(.*)$ /index.html [QSA,L]
    <Directory /var/www/tools/do.CRONje.ME>
	    Require all granted
        Options +Indexes +FollowSymLinks
        AllowOverride All
    </Directory>
    
    # If you want custom log files
    ErrorLog /var/www/tools/do.CRONje.ME/logs/error.log
    CustomLog /var/www/tools/do.CRONje.ME/logs/access.log combined
</VirtualHost>
```

- Remember to go and create the `logs` dir
- You probably want to adjust ServerName and DocumentRoot.
- Restart Apache

Next Step: Configure Fontend [Configure Frontend](vikunjaConfigureFrontend.md)