---
title: RegExr
---
<script type="text/javascript">(function(w,s){var e=document.createElement("script");e.type="text/javascript";e.async=true;e.src="https://cdn.pagesense.io/js/webally/f2527eebee974243853bcd47b32631f4.js";var x=document.getElementsByTagName("script")[0];x.parentNode.insertBefore(e,x);})(window,"script");</script>

RegExr is an online tool to learn, build, and test Regular Expressions.

## Features

- Results update in real-time as you type.
- Supports JavaScript & PHP/PCRE RegEx.
- Roll over a match or expression for details.
- Save & share expressions with others.
- Use Tools to explore your results.
- Browse the Reference for help & examples.
- Undo & Redo with cmd-Z / Y in editors.
- Search for & rate Community patterns.

## Build

- RegExr uses Gulp to manage the build process. 
- You will need to install Node and Gulp, and install other dependencies via npm install. 
- Running gulp (default) will run dev builds and set up a test server.

## Install Gulp

First of all, you need to install `node.js` on your CentOS system. Use following set of commands to add `node.js` yum repository on your `CentOS` system and install it.

```sh
sudo yum install -y gcc-c++ make
curl -sL https://rpm.nodesource.com/setup_12.x | sudo -E bash -
```

Then install the Nodejs package on your system.

```sh
sudo yum install nodejs
```

After installation of `Node.js` and Npm on your system, use the following commands to install Gulp CLI globally on your system.

```sh
npm install -g gulp-cli
```

You have successfully installed the Gulp CLI tool on your system. Switch to your existing node.js application directory or create a new application with the below commands:

```sh
mkdir my-project && cd my-project
node init
```

Then add the Gulp module to your project

```sh
npm install --save-dev gulp
```

All done, Let’s check the installed version of Gulp CLI on your system and Gulp module in your application with the following command.

```sh
gulp --version

CLI version: 2.2.0
Local version: 4.0.2
```

## Update g++

- You might need to update g++

> This can take a long time so don't just run this if it is not nessesary

```sh
sudo yum install libmpc-devel mpfr-devel gmp-devel

cd ~/Downloads
curl ftp://ftp.mirrorservice.org/sites/sourceware.org/pub/gcc/releases/gcc-4.9.2/gcc-4.9.2.tar.bz2 -O
tar xvfj gcc-4.9.2.tar.bz2

cd gcc-4.9.2
./configure --disable-multilib --enable-languages=c,c++
make -j 4
make install
```

## Update the SASS package version

Open `package.json`

```json
# Update
"sass": "^1.26.5",
# To
"sass": "^1.49.9",
```

## Update node-gyp is nessesary

```sh
npm remove -g node-gyp
npm install -g node-gyp
```

## Install RegExr

```sh
mkdir -p /var/www/tools/regex.CRONje.ME
cd /var/www/tools/regex.CRONje.ME
git clone https://github.com/gskinner/regexr.git .
npm install
gulp
```