---
title: Paper{s}pace
---
<script type="text/javascript">(function(w,s){var e=document.createElement("script");e.type="text/javascript";e.async=true;e.src="https://cdn.pagesense.io/js/webally/f2527eebee974243853bcd47b32631f4.js";var x=document.getElementsByTagName("script")[0];x.parentNode.insertBefore(e,x);})(window,"script");</script>

## Install Using Docker Command

```sh
sudo docker run --gpus all -d -p 8888:8888 paperspace/fastai:2.0-CUDA9.2-base-3.0-v0.0.11-jupyterlab
```

- The Docker container should contain all dependencies
- I use `NginX Proxy Manager` to point a `sub-domain` to port `8888`



