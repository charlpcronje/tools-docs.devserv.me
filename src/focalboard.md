---
title: focalboard Docker Install
---
<script type="text/javascript">(function(w,s){var e=document.createElement("script");e.type="text/javascript";e.async=true;e.src="https://cdn.pagesense.io/js/webally/f2527eebee974243853bcd47b32631f4.js";var x=document.getElementsByTagName("script")[0];x.parentNode.insertBefore(e,x);})(window,"script");</script>

I will be using portainer to install a new stack with Docker Compose

## Portainer Install

- Open Portainer
- Click on Stacks
- Give it a Name
- Copy and paste the follwing under the docker-compose field

```yml
version: '3.3'
services:
  focalboard:
    ports:
      - '6549:8000'
    restart: always
    image: mattermost/focalboard
```

