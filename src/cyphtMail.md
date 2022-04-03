# Install Cypht Mail Client

## Requirements

Cypht requires at least PHP 5.4, composer, and at minimum the `OpenSSL`, `mbstring` and `cURL` extensions. Cypht can also leverage several other extensions as defined here: [https://github.com/jasonmunro/cypht/blob/master/composer.json#L31-L37](https://github.com/jasonmunro/cypht/blob/master/composer.json#L31-L37). Testing is done on Debian and Ubuntu platforms with Nginx and Apache.

## Install with Docker Compose

```sh
version: '3'
services:
  db:
    image: mariadb:10
    volumes:
      - ./db:/var/lib/mysql
    environment:
      - MYSQL_ROOT_PASSWORD=root_password
      - MYSQL_DATABASE=cypht
      - MYSQL_USER=cypht
      - MYSQL_PASSWORD=cypht_password
  cypht:
    image: sailfrog/cypht-docker:latest
    volumes:
      - ./cypht/users:/var/lib/hm3/users
    ports:
      - "80:80"
    environment:
      - CYPHT_AUTH_USERNAME=admin
      - CYPHT_AUTH_PASSWORD=admin_password
      - CYPHT_DB_CONNECTION_TYPE=host
      - CYPHT_DB_HOST=db
      - CYPHT_DB_NAME=cypht
      - CYPHT_DB_USER=cypht
      - CYPHT_DB_PASS=cypht_password
      - CYPHT_SESSION_TYPE=DB
```

## Install with Script

### 1. Download and prepare the code

It's important to consider where you put the Cypht source. The web-server will need read-only access to it, and moving it from one place to another requires re-running the configuration script. Do NOT put the source in the document root as this could create a security risk. On Debian, it's common to use the `/usr/local/share/` sub-directory for a situation like this. Here is short bash script that will download the latest code, setup the correct permissions and ownership, put the source in `/usr/local/share/cypht`, and create a default hm3.ini file. It requires `sudo` access:

Below is a script that will download and install Cypht to `/usr/local/share/cypht`

[!ref Download Script](cypht-install.sh)

or

```sh
wget https://tools.docs.devserv.me/cyphtmail/cypht-install.sh
```

```sh
# cypht-install.sh

#!/bin/bash

# this is where Cypht will be installed
DESTINATION="/usr/local/share/cypht"

# validate the destination directory
sudo test -r $DESTINATION -a -x $DESTINATION
if [ $? -ne 0 ]; then
    sudo mkdir $DESTINATION
fi

# create working directory
mkdir cypht-temp
cd cypht-temp

# grab latest code
wget https://github.com/jasonmunro/cypht/archive/master.zip

# unpack the archive
unzip master.zip

# run composer
cd cypht-master && composer install && cd ..

# create a vanilla ini file
cp cypht-master/hm3.sample.ini cypht-master/hm3.ini

# fix permissions and ownership
find cypht-master -type d -print | xargs chmod 755
find cypht-master -type f -print | xargs chmod 644
sudo chown -R root:root cypht-master

# copy to destination folder
sudo mv cypht-master/* $DESTINATION

# remove working directory
cd ..
sudo rm -rf cypht-temp
```

### 2. Configure the program

To configure Cypht for your environment, you must first edit the hm3.ini file to your liking, then run the config_gen.php script to generate the optimized configuration file and assets used at run-time.

First edit the hm3.ini file to configure Cypht for your environment. If you choose to use a database for any of the 3 available purposes (authentication, sessions, or user settings), you will need to complete the "DB support" section and create the required tables. SQL to do so can be found in the hm3.sample.ini file. The ini file has lots of comments explaining what each option does.

Cypht needs read, and read-write access to a few directories on the server. For security reasons these should NOT be inside the web-server document root. A good place for these is under the /var/lib/ sub-directory. Here are the commands To create the required directories per the default values in the ini file (assuming your web-server software runs as the "www-data" user).

```sh
sudo mkdir /var/lib/hm3
sudo mkdir /var/lib/hm3/attachments
sudo mkdir /var/lib/hm3/users
sudo mkdir /var/lib/hm3/app_data

sudo chown -R www-data /var/lib/hm3/
```

The `/var/lib/hm3/users` directory is only required if you are using the file-system and not a database to store user settings (`user_config_type = file` in the hm3.ini). You can put these directories anywhere, just make sure the values in the ini file point to the right place.

### 3. Generate the run-time configuration
Cypht uses a build process to create an optimized configuration, and to combine and minimize page assets. Once you have edited your hm3.ini file, generate the configuration with:

```sh
cd /usr/local/share/cypht  (or wherever you put the code in section 1)
sudo php ./scripts/config_gen.php
```

This will create a sub-directory called site that contains the code and page assets that need to be inside the document `root`, and it creates an optimized configuration file called `hm3.rc` in the current directory. Anytime you change the ini file settings, or move the source location, you will need to re-run the config_gen script to update the program.

### 4. Enable the program in your web-server

The easiest way to serve Cypht is to symlink it to the web-server `document root`. You can also copy the generated files to your web-server location, but then you will need to `re-copy` them anytime the `config_gen` script is run. If the source is located at `/usr/local/share/cypht`, and the web-server document root is at `/var/www/html`, the following command will make Cypht available under the "mail" path of the web-server:

```sh
sudo ln -s /usr/local/share/cypht/site /var/www/html/mail
```

Now going to [https://your-server/mail/](https://your-server/mail/) should load the Cypht login page. Note that If you use a symlink, your web-server must be configured to follow symlinks.

### 5. Users

Setting up users depends on what type of authentication you configure in the `hm3.ini` file. If you are using the local database configuration for users, there are scripts in the `scripts/` directory to help manage them:

```sh
# create an account
php ./scripts/create_account.php username password

# delete an account
php ./scripts/delete_account.php username

# change an account password
php ./scripts/update_password.php username password
```

### 6. Debug mode

Cypht has a debug or developer mode that can be used to troubleshoot problems or enable faster development of modules. To enable the debug version of Cypht, just sym-link the entire source directory instead of the site sub-directory:

```sh
sudo ln -s /usr/local/share/cypht /var/www/html/mail-debug
```

Debug mode is not as efficient as the normal version, and it is NOT designed to be secure. **DO NOT RUN DEBUG MODE IN PRODUCTION**. You have been warned! Debug mode outputs lots of information to the PHP error log that can be useful for trouble-shooting problems. The location of the error log varies based on your php.ini settings and web-server software.

### 7. Other INI files

Some Cypht modules require additional ini files to be configured. These should NOT be inside the web-server document root. Cypht will look for them in the location defined by "app_data_dir" in the hm3.ini file. A sample ini file for each module set that requires one is included in the source for that module. To configure them you must copy the sample ini file to the "app_data_dir" and edit it for your setup. Some of these require configuring your service with a provider, specifically ones related to Oauth2 client setup (`Github`, `WordPress`, `Oauth2` over `IMAP` for `Gmail` and `Outlook`). Re-run the config_gen script after configuring an `ini` file and it will be merged into the main configuration settings.


### Github

Cypht can connect to github and aggregate notification data about repository activity.

- **Example github.ini file:**

https://github.com/jasonmunro/cypht/blob/master/modules/github/github.ini

- **Authorize an application for github:**

https://github.com/settings/developers

### OAUTH2 over IMAP

Gmail and Outlook.com support OAUTH2 authentication over IMAP. This is preferable to normal IMAP authentication because Cypht never has access to your account password.

- **Example oauth2 ini file:**

[https://github.com/jasonmunro/cypht/blob/master/modules/imap/oauth2.ini](https://github.com/jasonmunro/cypht/blob/master/modules/imap/oauth2.ini)

- **Authorize an application for gmail**

[https://console.developers.google.com/project](https://console.developers.google.com/project)

- **Authorize an application for outlook.com**

[https://account.live.com/developers/applications/](https://account.live.com/developers/applications/)

### LDAP ldap_contacts

Cypht can use an LDAP server for contacts.

- **Example ldap.ini file:**

[https://github.com/jasonmunro/cypht/blob/master/modules/ldap_contacts/ldap.ini](https://github.com/jasonmunro/cypht/blob/master/modules/ldap_contacts/ldap.ini)

### WordPress

Cypht can aggregate WordPress.com notifications.

- **Example wordpress.ini file:**

[https://github.com/jasonmunro/cypht/blob/master/modules/wordpress/wordpress.ini](https://github.com/jasonmunro/cypht/blob/master/modules/wordpress/wordpress.ini)

- **Authorize an application for WordPress.com:**

[https://developer.wordpress.com/apps/](https://developer.wordpress.com/apps/)

### Custom themes

You can create your own themes for Cypht. Edit the themes.ini file to include your theme, and put the css file in modules/themes/assets.

[https://github.com/jasonmunro/cypht/blob/master/modules/themes/themes.ini](https://github.com/jasonmunro/cypht/blob/master/modules/themes/themes.ini)
