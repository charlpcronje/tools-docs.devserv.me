# Fix Web Permissions

It will happen almost all the time when you copy some files from your local machine to your dev server that the file permissions won't be correcy.

- Folder permissions should be 644
- File permissions should be 755

- The above may be different in folers where you want write permissions etc. But for most caeses the above will work fine.
- But of course setting every foler to 644 and files to 755 will take a long time.

Or you can create a .sh script and paste the following

```sh
if [[ -z $1 ]]
then
    FIXPATH="-h"
        echo "fwp [path] [user:group]"
else
        FIXPATH="$1"

        echo "setting folder permissions to 755 recursive from $FIXPATH"
        find "$FIXPATH" -type d -exec chmod 755 {} \;


        echo "setting file permissions to 644 recursive from $FIXPATH"
        find "$FIXPATH" -type f -exec chmod 644 {} \;

        if [[ -z $2 ]]
        GROUPTOSET="$2"
        then
                echo "Setting folder $FIXPATH to be owned by $GROUPTOSET"
                find "$FIXPATH" -exec chown "$GROUPTOSET" {} \;
        fi
        echo "restarting Apache"
        echo systemctl restart httpd
fi
```

This script takes two paramaters:

- The first param is the full path of the folders you want to affect
- The second param is the user and group you want to assign

Example

```sh
./fixWebPermissions.sh /var/www apache:apache
```

- But we want the script to global accesible, and you need to make it executable

```sh
chmod +x /srv/scripts/fixWebPermissions.sh   #make is executable
ln -s /usr/bin/fwp /src/scripts/fixWebPermissions.sh
```

Now you can run the script from anywhere by executing the following command:

```sh
fwp /var/www apache:apache
```
