---
order: 8
title: Install Vikunja TODO Frontend
---
<script type="text/javascript">(function(w,s){var e=document.createElement("script");e.type="text/javascript";e.async=true;e.src="https://cdn.pagesense.io/js/webally/f2527eebee974243853bcd47b32631f4.js";var x=document.getElementsByTagName("script")[0];x.parentNode.insertBefore(e,x);})(window,"script");</script>

- You can get all frontend releases from our [download server](https://dl.vikunja.io/frontend)
- You can also [get the source code](http://code.vikunja.io/frontend) and build it yourself. Instructions on how to do this can be found in the repo.
 
Go to the releases page and download the latest stable release, in my case it is: [https://dl.vikunja.io/frontend/vikunja-frontend-unstable.zip](https://dl.vikunja.io/frontend/vikunja-frontend-unstable.zip)

Execute the following commands 

```sh
mkdir /var/www/tools/do.CRONje.ME
cd /var/www/tools/do.CRONje.ME
```

- Download and extract ZIP file

```sh
wget https://dl.vikunja.io/frontend/vikunja-frontend-unstable.zip
unzip vikunja-frontend-unstable.zip
```

Next Step: Setup Virtual Host in Apache [Virtual Host](vikunjaVhost.md)
