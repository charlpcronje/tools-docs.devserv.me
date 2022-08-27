---
title: Install R | CRONje.ME
label: Install R
order: 10
authors:
  - name: Charl Cronje
    email: charl@CRONje.ME
    link: https://blog.cronje.me
    avatar: https://assets.cronje.me/avatars/darker.jpg
---
<script type="text/javascript">(function(w,s){var e=document.createElement("script");e.type="text/javascript";e.async=true;e.src="https://cdn.pagesense.io/js/webally/f2527eebee974243853bcd47b32631f4.js";var x=document.getElementsByTagName("script")[0];x.parentNode.insertBefore(e,x);})(window,"script");</script>

# Install R Programming Langauge

## Install Procedure

The procedure here for enabling R and RStudio is very much so a traditional installation with a few caveats at the end of each section. In particular, the caveats relate to installing packages once, updating packages once, and disabling calls to `CRAN` to prevent console crashes.

Code for the procedure can be found at:

[https://github.com/coatless/r-centos7/](https://github.com/coatless/r-centos7/)

As a result, the code contained within this post may be outdated.

### R Installing on CentOS 7 

Installing R on the CentOS 7 environment mirrors that of prior installation tutorials and manuals. In particular, we have the following routine:

=== Add Development Tools
### Install development tools

```sh
sudo yum groupinstall -y "Development Tools"
```

### Install Latest R Version

```sh
sudo yum install -y epel-release
```

### Install R from the repository

```sh
sudo yum install -y R
```

### Add additional system libraries

### Required for png and jpeg packages used with mapping

```sh
sudo yum install -y libpng-devel  \
                    libjpeg-turbo-devel

### These libraries relate to web scraping technology
### They are primarily used by rvest + devtools
sudo yum install -y libxml2-devel \
                    libcurl-devel \
                    openssl-devel \
                    libssh2-devel
```

=== Installation and Update of R Packages

At this point, there are three parts to adding in external packages:

1. Use Rscript to run an R script that installs each package desired;
2. check RStudio’s package dependency mannger for any changes; and,
3. write a custom .Rprofile that disables CRAN by redirecting the repos parameter in install.packages() to a local directory that is not setup to act like CRAN.

**Note:** You can actually implement a mini-CRAN using drat and miniCRAN.
For those who have been through this rodeo before, the second step might throw you. Why do we need to look at RStudio’s dependency manager? Well, the dependency manager is hard coded and non-accessible via R. As a result, there may be a requirement RStudio checks that wouldn’t be listed in an R package’s DESCRIPTION file. Thus, you may inadvertently run into trouble when working with a feature in RStudio.

Installing R Packages from CRAN
One of the main reasons why R is so popular is the wide array of packages available through the Comprehensive R Archive Network (CRAN).
For demonstration purposes, we’ll install a package named stringr , which provides fast and correct implementations of common string manipulations.
When started as root the packages will be installed globally and available for all system users. If you start R without sudo, a personal library will be set up for your user.

Start by opening the R console as a root:


```sh
sudo -i R

# Output
R version 3.5.0 (2018-04-23) -- "Joy in Playing"
Copyright (C) 2018 The R Foundation for Statistical Computing
Platform: x86_64-redhat-linux-gnu (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

  Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.
```

> All the following commands are executed within the R console.

Install the stringr package by running the following command:

```R
install.packages("stringr")
```

You will be asked to select a CRAN mirror:

```sh
# Output
Installing package into ‘/usr/lib64/R/library’
(as ‘lib’ is unspecified)
--- Please select a CRAN mirror for use in this session ---
Secure CRAN mirrors 
```

Select the mirror that is closest to your location.

The installation will take some time and once completed, load the library by typing:

```R
library(stringr)
```

Next, create a simple character vector named `tutorial`:

```sh
tutorial <- c("How", "to", "Install", "R", "on", "CentOS", "7")
```

Run the following function which will print the length of each string:

```sh
str_length(tutorial)

# Output
[1] 3 2 7 1 2 6 1
```

You can find more R packages at Available CRAN Packages By Name and install them with install.packages().

## Conclusion

You have successfully installed R your CentOS machine and learned how to install R packages.
===