---
title: Hoppscotch Quick Deploy
---
<script type="text/javascript">(function(w,s){var e=document.createElement("script");e.type="text/javascript";e.async=true;e.src="https://cdn.pagesense.io/js/webally/f2527eebee974243853bcd47b32631f4.js";var x=document.getElementsByTagName("script")[0];x.parentNode.insertBefore(e,x);})(window,"script");</script>

## Install prerequisites

You need Docker running on your VPS

```sh
docker run -d --name hoppscotch -p 3123:3000 --restart=unless-stopped hoppscotch/hoppscotch:latest
```