# Piwigo Photo Gallery

**Website:** [https://piwigo.com](https://piwigo.com/)

## Installation [https://piwigo.org/guides/install/manual](https://piwigo.org/guides/install/manual)


### Download and Extract Archive

- Download the archive: To get the newest version visit: [https://piwigo.org/get-piwigo](https://piwigo.org/get-piwigo), right click on `download Piwigo 12.2.0` or whatever the current version number is and click on `copy link`
- SSH to your server

```sh
mkdir -p /var/www/tools/[folder name]/public
mkdir -p /var/www/tools/[folder name]/logs 
cd mkdir -p /var/www/tools/[folder name]/public
wget [copied link]

unzip [ZIP file name]
```

### Configuration

Setup new Virtual Host

```conf
<VirtualHost *:80>
    ServerName gallery.example.com
    ServerAdmin admin@example.com
    DocumentRoot /var/www/tools/gallery.example.com/public
    <Directory /var/www/tools/gallery.example.com/public>
        Require all granted
        Options -Indexes +FollowSymLinks
        AllowOverride All
    </Directory>
    ErrorLog /var/www/tools/gallery.example.com/logs/error.log
    CustomLog /var/www/tools/gallery.example.com/logs/access.log combined
</VirtualHost>
```

- Restart Apache

```sh
systemctl restart httpd
```

- With a web browser go to, for example http://gallery.example.com Piwigo will detect nothing is installed yet, and redirect you to the installation page.
- Now comes the MySQL database settings and the webmaster account to administer your gallery
- Fill in MySQL database connection settings, as given by your web hosting provider::

- **Host**
- **User** `(Warning, your web hosting provider may provide separate connection settings for FTP and MySQL.)`
- **Password**
- **Database name**
- A prefix for Piwigo table names `(Most often, web hosting providers allow a single database per customer, but you can create as many tables as you want in the same database. To avoid conflicts with other web applications, or allow several Piwigo installations on the same website, the table names have a prefix. By default, this prefix is ”piwigo_”, but you can change it (only alphanumeric characters are allowed).)`

> The following is required to create the webmaster account:

- An account identifier, chosen by you
- A password you have to enter twice, for checking
Your email address, so that visitors can contact you
- **Run the “Start Install” action.**


### First connection

Once the installation is finished, you can go into your gallery. 

> Login with your webmaster account, and you can reach the administration panel.


