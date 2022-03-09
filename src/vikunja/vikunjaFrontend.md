---
order: 8
---
# Install Vikunja TODO Frontend

- You can get all frontend releases from our [download server](https://dl.vikunja.io/frontend)
- You can also [get the source code](http://code.vikunja.io/frontend) and build it yourself. Instructions on how to do this can be found in the repo.
 
Go to the releases page and download the latest stable release, in my case it is: [https://dl.vikunja.io/frontend/vikunja-frontend-unstable.zip](https://dl.vikunja.io/frontend/vikunja-frontend-unstable.zip)

Execute the following commands 

```sh
mkdir /var/www/tools/do.devserv.me
cd /var/www/tools/do.devserv.me
```

- Download and extract ZIP file

```sh
wget https://dl.vikunja.io/frontend/vikunja-frontend-unstable.zip
unzip vikunja-frontend-unstable.zip
```

Next Step: Setup Virtual Host in Apache [Virtual Host](vikunjaVhost.md)
