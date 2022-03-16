# Troubleshooting

## Tomcat Server

By default, Apache Tomcat runs on port `8080`. In some cases, this port may already be taken by another process, or requirements may state that we have to use a different port.

In this quick article, we're going to show how to change Apache Tomcat server's HTTP port. We'll use port 80 in our examples, although the process is the same for any port.

 ### Apache Tomcat Configuration

 The first step in this process is to modify the Apache Tomcat configuration.

First, we locate our server's `<TOMCAT_HOME>/conf/server.xml` file. Then we find the line that configures the HTTP connector port:

```xml
<Connector connectionTimeout="20000" port="8080" protocol="HTTP/1.1" redirectPort="8443"/>
```

And we change the port to 80:

```xml
<Connector connectionTimeout="20000" port="80" protocol="HTTP/1.1" redirectPort="8443"/>
```

### Linux and Unix System Changes

On Linux and Unix systems, port numbers below `1024` are privileged ports and are reserved for programs running as `root`. If we're running on port `1024` or higher, then we can skip the remainder of this section and move directly to starting/restarting your server

If we have `root` or `sudo` access, we can simply start the Tomcat process as root using the command:

```sh
sudo startup.sh
```

But if we do not have `root` or `sudo` access, we'll have to install and configure `authbind`, as described below.


**Note**: when using a non-privileged port (`1024` or higher), we can skip the remainder of this section and move directly to starting/restarting our server.

### Install authbind Package

For Linux-based systems: download and install the authbind package:

```sh
sudo apt-get install authbind
```

### Enable authbind on Apache Tomcat
Open `<TOMCAT_HOME>/conf/server.xml` file uncomment following line:

`AUTHBIND=yes`

### Enable Read and Execute for Port

Now we'll need to execute a few commands to enable read and execute permissions for the port.


Here's an example using Tomcat version 8.x:

```sh
sudo touch <AUTHBIND_HOME>/byport/80
sudo chmod 500 <AUTHBIND_HOME>/byport/80
sudo chown tomcat8 <AUTHBIND_HOME>/byport/80
```

Note: if using Tomcat version 6 or 7, then we would use ``tomcat6`` or `tomcat7`, respectively, in the last command instead of `tomcat8`.

### Using Older Versions of `authbind`

If using an older authbind (version lower than 2.0.0) that does not support IPv6, we'll need to make IPv4 the default.


If we already have a `<TOMCAT_HOME>/bin/setenv.sh` file, then replace:

```sh
exec "$PRGDIR"/"$EXECUTABLE" start "$@"
```

with this line:

```sh
exec authbind --deep "$PRGDIR"/"$EXECUTABLE" start "$@"
```

and then add the following line:

```sh
export CATALINA_OPTS="$CATALINA_OPTS -Djava.net.preferIPv4Stack=true"
```

If we don't already have `<TOMCAT_HOME>/bin/setenv.sh` file, then create one using:

```sh
exec authbind --deep "$PRGDIR"/"$EXECUTABLE" start "$@"
export CATALINA_OPTS="$CATALINA_OPTS -Djava.net.preferIPv4Stack=true"
```

### Restart Server

Now as we have made all necessary changes to our configuration, we can start or restart the Tomcat server and access it on port 80.