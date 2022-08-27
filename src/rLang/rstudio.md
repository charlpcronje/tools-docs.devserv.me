---
title: Install RStudio | CRONje.ME
label: Install RStudio
order: 162
authors:
    - name: Charl Cronje
      email: charl@CRONje.ME
      link: https://blog.cronje.me
      avatar: https://assets.cronje.me/avatars/darker.jpg
tags: [dev,tools,start,js,php,frontend,backend,developer,devtools,helpers,log]
---
<script type="text/javascript">(function(w,s){var e=document.createElement("script");e.type="text/javascript";e.async=true;e.src="https://cdn.pagesense.io/js/webally/f2527eebee974243853bcd47b32631f4.js";var x=document.getElementsByTagName("script")[0];x.parentNode.insertBefore(e,x);})(window,"script");</script>

RStudio Server is the web edition of RStudio which is a series of tools designed to facilitate the coding job using the R programming language.

## Prerequisites

A CentOS 7 server instance with at least 1GB of RAM, 2GB of RAM or more recommended.
A sudo user.

### Step 1: Update the system

Log in as a sudo user, and then execute the below commands:

```sh
sudo yum install epel-release
sudo yum update
sudo shutdown -r now
```

After the reboot, use the same sudo user to log in back.

### Step 2: Install R

```sh
sudo yum install R -y
Step 3: Install RStudio Server
```

Use the following commands to install the latest stable release of RStudio Server. At the time this article was written, it is 1.0.136.

```sh
cd
wget https://download2.rstudio.org/rstudio-server-rhel-1.0.136-x86_64.rpm
sudo yum install --nogpgcheck rstudio-server-rhel-1.0.136-x86_64.rpm -y
```

Note: You can always find the latest release of RStudio Server from its official download page.

After the installation, the RStudio Server service should have gotten started. You can check its status and set it to run on boot as below:

```sh
sudo systemctl status rstudio-server.service
sudo systemctl enable rstudio-server.service
```

### Step 4: Access RStudio Server from a web browser

In order to allow web access, you need to modify firewall settings as below:

```sh
sudo firewall-cmd --permanent --zone=public --add-port=8787/tcp
sudo firewall-cmd --reload
```

Now, point your web browser to `http://203.0.113.1:8787`, and then sign in with the credentials of the current sudo user. If nothing goes wrong, you will be brought into the RStudio Server IDE in which you can write and test your R code.

### Step 5 (optional): Add more packages from CRAN

If you want to install more packages from CRAN (Comprehensive R Archive Network), you can make it happen as follows:

### Install development tools:

```sh
sudo yum groupinstall "Development Tools" -y
```

Enter the R shell:

```sh
sudo -i R
```

Install the package you need as below, and more packages can be installed in the same fashion:

```sh
install.packages('txtplot')

# quit the R shell:

q()
```