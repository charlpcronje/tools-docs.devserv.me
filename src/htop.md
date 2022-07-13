---
title: Htop
---
<script type="text/javascript">(function(w,s){var e=document.createElement("script");e.type="text/javascript";e.async=true;e.src="https://cdn.pagesense.io/js/webally/f2527eebee974243853bcd47b32631f4.js";var x=document.getElementsByTagName("script")[0];x.parentNode.insertBefore(e,x);})(window,"script");</script>

[Htop](https://htop.dev/) is an interactive real-time process monitoring application for Linux/Unix-like systems and also a handy alternative to [top command(https://www.tecmint.com/12-top-command-examples-in-linux/)], which is a default process monitoring tool that comes pre-installed on all Linux operating systems.

Htop has numerous other user-friendly features, which are not available under the top command and they are:

- In htop, you can scroll vertically to view the full process list and scroll horizontally to view the full command lines.
- It starts very quickly as compared to the top because it doesn’t wait to fetch data during startup.
- In htop, you can [kill more than one process](https://www.tecmint.com/find-and-kill-running-processes-pid-in-linux/) at once without inserting their PIDs.
- In htop, you no longer needed to enter the process number or priority value to re-nice a process.
- Press “e” to print the set of environment variables for a process.
- Use the mouse to select list items.

## Install Htop

### Install Htop on Debian

```sh
sudo apt install htop
```

### Install Htop on Ubuntu

```sh
sudo apt install htop
```

### Install Htop on Linux Mint

```sh
sudo apt install htop
```

### Install Htop on Fedora

```sh
sudo dnf install htop
```

### Install Htop on CentOS 8/7

```sh
sudo yum install epel-release
sudo yum install htop
```

### Install Htop on RHEL 8/7

```sh
--------- On RHEL 8 --------- 
sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
sudo yum install htop

--------- On RHEL 7 ---------
sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum install htop
```

### Install Htop on Rocky Linux/AlmaLinux

```sh
sudo yum install epel-release
sudo yum install htop
```

### Install Htop on Gentoo

```sh
$ emerge sys-process/htop
```

### Install Htop on Arch Linux

```sh
pacman -S htop
```

### Install Htop on OpenSUSE

```sh
sudo zypper install htop
```
