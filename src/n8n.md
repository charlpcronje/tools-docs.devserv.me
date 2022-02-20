# Self-hosting n8n

## Running n8n

I created a bash script to start the container with some different settings:

```shell
sh /var/www/tools/n8n/start.sh

# Initializing n8n process
# UserSettings were generated and saved to: /home/node/.n8n/config
```

n8n can be access on devserv.me:5678

You can install via Docker or npm.

## npm

You can try n8n without installing it using npx.

From the terminal, run:

```shell
npx n8n
```

This command will download everything that is needed to start n8n. You can then access n8n and start building workflows by opening [http://localhost:5678](http://localhost:5678) (opens new window).

If you want to install n8n globally, use npm:

```shell
npm install n8n -g
```

After the installation, start n8n by running:

```shell
n8n
# or
n8n start
```

## 💡 Keep in mind

Windows users remember to change into the .n8n directory of your Home folder (~/.n8n) before running n8n start.

### Docker

See the Docker installation page for running n8n using Docker.

`n8n` also offers a `Docker` image for Raspberry Pi: `n8nio/n8n:latest-rpi`.

### n8n with tunnel

To be able to use webhooks for trigger nodes of external services like GitHub, n8n has to be reachable from the web. To make that easy, n8n has a special tunnel service (opens new window)which redirects requests from our servers to your local n8n instance.

If you installed `n8n` with `npm`, start `n8n` with `--tunnel` by running:

```shell
n8n start --tunnel
```

If you are running n8n with Docker, start n8n with --tunnel by running:

```shell
docker run -it --rm \
--name n8n \
-p 5678:5678 \
-v ~/.n8n:/home/node/.n8n \
n8nio/n8n \
n8n start --tunnel
```
