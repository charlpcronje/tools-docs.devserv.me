# Download RStudio Server for Red Hat/CentOS

Look at: https://www.youtube.com/watch?v=c4Af2FcgamA for a good data science project

## Prerequisites

RStudio Server requires Red Hat or CentOS version 7 (or higher) as well as an installation of R. You can install R for Red Hat and CentOS using the instructions in RStudio’s documentation(opens in a new tab).

## Install for Red Hat / CentOS 7

```shell
sudo yum install R -y
```

To download and install RStudio Server open a terminal window and execute the following commands.
Size:  61.20 MB | SHA-256: 3e7af171 | Version:  2021.09.2+382| Released:  2022-01-10

```shell
cd
wget https://download2.rstudio.org/rstudio-server-rhel-1.0.136-x86_64.rpm
sudo yum install --nogpgcheck rstudio-server-rhel-1.0.136-x86_64.rpm -y
```

**Note**: You can always find the latest release of RStudio Server from its official download page.

After the installation, the RStudio Server service should have gotten started. You can check its status and set it to run on boot as below:

```shellsudo systemctl status rstudio-server.service
sudo systemctl enable rstudio-server.service
```

## Install for Red Hat / CentOS 8

To download and install RStudio Server open a terminal window and execute the following commands.
Size:  61.19 MB | SHA-256: bbf9a91c | Version:  2021.09.2+382| Released:  2022-01-10

```shell
wget https://download2.rstudio.org/server/centos8/x86_64/rstudio-server-rhel-2021.09.2-382-x86_64.rpm
sudo yum install rstudio-server-rhel-2021.09.2-382-x86_64.rpm
```

## Accessing RStudio Server

By default RStudio Server runs on port 8787 and accepts connections from all remote clients. After installation you should therefore be able to navigate a web browser to the following address to access the server:

[http://<server-ip>:8787](http://<server-ip>:8787)
RStudio will prompt for a username and password, and will authenticate the user by checking the server's username and password database.

A couple of notes related to user authentication:

- RStudio Server will not permit logins by system users (those with user ids lower than 100).
- User credentials are encrypted using RSA as they travel over the network.
- You can manage users with standard Linux user administration tools like useradd, userdel, etc.
- Each user needs to be created with a home directory.

    If you are unable to access the server after installation, you should run the verify-installation command to output additional diagnostics:

```shell
sudo rstudio-server verify-installation
```
