# ---
title: Deploy your own search engine with SearXNG
---
<script type="text/javascript">(function(w,s){var e=document.createElement("script");e.type="text/javascript";e.async=true;e.src="https://cdn.pagesense.io/js/webally/f2527eebee974243853bcd47b32631f4.js";var x=document.getElementsByTagName("script")[0];x.parentNode.insertBefore(e,x);})(window,"script");</script>

> Privacy-respecting, hackable metasearch engine

## Differences to searx

- SearXNG is a fork of searx. Here are some of the changes:

## User experience

- Huge update of the simple theme:
- usable on desktop, tablet and mobile
- light and dark versions (you can choose in the preferences)
- support right-to-left languages

## see the screenshots

- the translations are up to date, you can contribute on Weblate
- the preferences page has been updated:
  - you can see which engines are reliable or not
  - engines are grouped inside each tab
  - each engine has a description

thanks to the anonymous metrics, it is easier to report a bug of an engine and thus engines get fixed more quickly
if you don't want any metrics to be recorded, you can disable them on the server

administrator can block and/or replace the URLs in the search results

## Setup

- you don't need Morty to proxy the images even on a public instance
- you don't need Filtron to block bots, we implemented the builtin limiter
- you get a well maintained Docker image, now also built for ARM64 and ARM/v7 architectures
- alternatively we have up to date installation scripts

## Install

- SSH into your server
- Create a directory

```sh
mkdir /var/www/tools/search.cronje.me
cd /var/www/tools/search.cronje.me
```

Clone SearXNG

```sh
git clone https://github.com/searxng/searxng-docker.git .

# Output
Cloning into '.'...
remote: Enumerating objects: 272, done.
remote: Counting objects: 100% (33/33), done.
remote: Compressing objects: 100% (11/11), done.
remote: Total 272 (delta 23), reused 23 (delta 22), pack-reused 239
Receiving objects: 100% (272/272), 70.19 KiB | 8.77 MiB/s, done.
Resolving deltas: 100% (153/153), done.
```

- Create secret key

```sh
sed -i "s|SuperSecretKey|$(openssl rand -hex 32)|g" searxng/settings.yml
```


- Update `searxng/settings.yml`

```yml
# see https://docs.searxng.org/admin/engines/settings.html#use-default-settings
use_default_settings: true
server:
  # base_url is defined in the SEARXNG_BASE_URL environment variable, see .env and docker-compose.yml
  secret_key: "supersecretkey"  # change this!
  limiter: true  # can be disabled for a private instance
  image_proxy: true
  method: "GET"
ui:
  static_use_hash: true
redis:
  url: redis://redis:6379/0
general:
  debug: false
  instance_name: "Cronje.Search.ME"
  contact_url: false
  enable_metrics: false
search:
  safe_search: 0
  autocomplete: "google"
```

- Start the container

```sh
docker-compose up -d
```