---
title: Munin
---
<script type="text/javascript">(function(w,s){var e=document.createElement("script");e.type="text/javascript";e.async=true;e.src="https://cdn.pagesense.io/js/webally/f2527eebee974243853bcd47b32631f4.js";var x=document.getElementsByTagName("script")[0];x.parentNode.insertBefore(e,x);})(window,"script");</script>

[Munin](https://munin-monitoring.org/) is open source and free software for monitoring computer system, network monitoring and application infrastructure monitoring software. 
Munin offers monitoring and alerting for servers, switches, applications, and services.

Munin can help system administrators to analyze the trend of the computer system whether it is experiencing problems or not. 
It can be an easier alternative to the popular open-source software [zabbix monitoring](https://webhostinggeeks.com/howto/how-to-install-zabbix-2-2-server-on-centos-6-5/).

In this article, I will explain how you can monitor your linux CentOS with Munin and the simple steps to install and setup Munin on CentOS 7.

## Install and Setup Munin on CentOS 7

1. Enable or install the EPEL Repository into CentOS 7. Read more on [how to Enable EPEL Repository on CentOS 7 / RHEL 7](https://webhostinggeeks.com/howto/epel-yum-repository-on-linux/)

2. Munin requires a web server to run. In this article, we will use apache. Install apache, Munin and Munin Node with yum command:

```sh
yum install httpd munin munin-node -y
```

3. Start and enable apache and munin at boot.

```sh
systemctl start httpd
systemctl enable httpd
systemctl start munin-node
systemctl enable munin-node
```

4. We want munin to use the name centos72.ehowstuff.local instead of localhost. Please open edit the setting in /etc/munin/munin.conf

```sh
vim /etc/munin/munin.conf
```

Original:

```sh
[localhost]
    address 127.0.0.1
    use_node_name yes
```

Change to:

```sh
[centos72.ehowstuff.local]
    address 127.0.0.1
    use_node_name yes
```

5. You also have optional to change the munin node hostname:

```sh
vim /etc/munin/munin-node.conf
```

Original:

```sh
host_name localhost.localdomain
```

Change to:

```sh
host_name centos72.ehowstuff.local
```

Next go to the Apache virtual host configuration file to add the permission to access your network.

```sh
vim /etc/httpd/conf.d/munin.conf
```

Add network segment that you allow to access to the CentOS server.

```sh
AuthUserFile /etc/munin/munin-htpasswd
AuthName "Munin"
AuthType Basic
require valid-user

Order Deny,Allow
Deny from all
Allow from 127.0.0.1 192.168.0.0/24
..
..
```

7. Munin statistics page shall be protected by a username and password. We can add the new user (admin) and password to /etc/munin/munin-htpasswd with htpasswd command line. So we have to setup basic Apache authentication before we can start access the munin statistic page.

```sh
# htpasswd /etc/munin/munin-htpasswd admin
New password:
Re-type new password:
Adding password for user admin
```

8. Allow port 80 in the firewalld permanently. learn more how to configure Firewalld on CentOS 7.
