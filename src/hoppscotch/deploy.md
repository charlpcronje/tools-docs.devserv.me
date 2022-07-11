# Hoppscotch Quick Deploy

## Install prerequisites

You need Docker running on your VPS

```sh
docker run -d --name hoppscotch -p 3123:3000 --restart=unless-stopped hoppscotch/hoppscotch:latest
```