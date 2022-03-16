# Install ReportServer

Now run the following command to create a new database for `ReportServer` database `reportserver`.

```sh
sudo -u postgres createdb reportserver
```

Now run the following command to create a new user for ReportServer database.

```sh
sudo -u postgres createuser -P -s -e reportserver
```

You will need to enter the password twice. You should get the following output.

```sh
# sudo -u postgres  createuser -P -s -e reportserver
Enter password for new role:
Enter it again:
CREATE ROLE reportserver PASSWORD 'md5171d269772c6fa27e2d02d9e13f0538b' SUPERUSER CREATEDB CREATEROLE INHERIT LOGIN;
```

Now assign the database user to the database using following command.

```sh
sudo -u postgres psql
GRANT ALL PRIVILEGES ON DATABASE reportserver TO reportserver;
```

exit the shell using `\q`

Now you will need to edit a PostgreSQL configuration file so that the database can be connected without the postgres user. Edit the pg_hba.conf using any editor.

```sh
nano /var/lib/pgsql/data/pg_hba.conf
```

Find the following lines and change peer to trust and idnet to md5.

```sh
# TYPE  DATABASE        USER            ADDRESS                 METHOD

# "local" is for Unix domain socket connections only
local   all             all                                     peer
# IPv4 local connections:
host    all             all             127.0.0.1/32            ident
# IPv6 local connections:
host    all             all             ::1/128                 ident
```

Once updated, the configuration should look like shown below.

```sh
# TYPE  DATABASE        USER            ADDRESS                 METHOD

# "local" is for Unix domain socket connections only
local   all             all                                     trust
# IPv4 local connections:
host    all             all             127.0.0.1/32            md5
# IPv6 local connections:
host    all             all             ::1/128                 md5
Now restart PostgreSQL server using the following command.
```

```sh
systemctl restart postgresql
```

## Install ReportServer

Now that we have both Tomcat and PostgreSQL setup, we can download and setup ReportServer. Run the following command to download ReportServer using following command.

```sh
wget https://downloads.sourceforge.net/project/dw-rs/bin/3.0/RS3.0.2-5855-2016-05-29-17-55-24-reportserver-ce.zip -O reportserver.zip
```

You can always find the link to the latest version using the following link.

Now remove everything in the web ROOT folder of Tomcat installation using the following command.

```sh
rm -rf /opt/tomcat/webapps/ROOT/*
```

Now extract the ReportServer archive using the following command.

```sh
unzip reportserver.zip -d /opt/tomcat/webapps/ROOT/
```

Now copy the configuration file from the example files using the following command.

```sh
cp /opt/tomcat/webapps/ROOT/WEB-INF/classes/persistence.properties.example /opt/tomcat/webapps/ROOT/WEB-INF/classes/persistence.properties
```

Now open the persistence.properties file and provide the database information which we have created earlier.

```sh
nano /opt/tomcat/webapps/ROOT/WEB-INF/classes/persistence.properties
```

Now add the following lines at the end of the file.

```conf
hibernate.connection.username=reportserver
hibernate.connection.password=StrongPassword
hibernate.dialect=net.datenwerke.rs.utils.hibernate.PostgreSQLDialect
hibernate.connection.driver_class=org.postgresql.Driver
hibernate.connection.url=jdbc:postgresql://localhost/reportserver
```

Change the username, password and database name according to the database set created by you.

Now provide the necessary ownership using the following command.

```sh
chown -R tomcat:tomcat /opt/tomcat/webapps/ROOT/
```

Now initialize the ReportServer database using the following command.

```sh
psql -U reportserver -d reportserver -a -f /opt/tomcat/webapps/ROOT/ddl/reportserver-RS3.0.2-5855-schema-PostgreSQL_CREATE.sql
```

It will ask you the password of your database user, provide the password and it will run the DDL script to initialize the database.

Finally, you will need to create a Systemd script to run tomcat server.

Create a new Systemd file using the following command.

```sh
nano /etc/systemd/system/tomcat.service
```

Copy and paste the following content into the file.

```conf
[Unit]
Description=Apache Tomcat Web Application Container
After=syslog.target network.target

[Service]
Type=forking

Environment=JRE_HOME=/usr/java/jdk1.8.0_131/jre
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat
Environment='JAVA_OPTS="-Djava.awt.headless=true -Xmx2g  -XX:+UseConcMarkSweepGC -Dfile.encoding=UTF8 -Drs.configdir=/opt/reportserver"'

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

User=tomcat
Group=tomcat
UMask=0007
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
```

Now you can start the application using the following command.

```sh
systemctl start tomcat
```

To enable Tomcat service to automatically start at boot time, run the following command.

```sh
systemctl enable tomcat
```

To check if the service is running, run the following command.

```sh
systemctl status tomcat
```

If the service is running, you should get the following output.

```sh
[root@liptan-pc reportserver]# systemctl status tomcat
? tomcat.service - Apache Tomcat Web Application Container
   Loaded: loaded (/etc/systemd/system/tomcat.service; enabled; vendor preset: disabled)
   Active: active (running) since Wed 2017-06-07 15:00:32 UTC; 4min 41s ago
 Main PID: 13179 (java)
   CGroup: /system.slice/tomcat.service
           ??13179 /usr/java/jdk1.8.0_131/jre/bin/java -Djava.util.logging.config.file=/opt/tomcat/conf/logging.propert...

Jun 07 15:00:32 liptan-pc systemd[1]: Starting Apache Tomcat Web Application Container...
Jun 07 15:00:32 liptan-pc systemd[1]: Started Apache Tomcat Web Application Container.
```

You can now access your application on the following URL.

[http://your-server-ip:8080](http://your-server-ip:8080)

You will see the following login interface..

![img](https://www.howtoforge.com/images/how_to_install_reportserver_on_centos_7/Image_23.jpg?ezimgfmt=rs:550x271/rscb5/ng:webp/ngcb5)

