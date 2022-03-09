# Self-hosting n8n

- `n8n` is a workflow automation tool and it can integrate with most public `API's`. The reason why I'm using it to `automate` the deployment of software every time a new release of my software is added to `GITHUB`
- A release of `GitHub` is not something that happens with every commit, a release is created specifically when you are ready with the new version of your software and it is ready to be shipped to your clients.
- In many cases the deploy process is manual, so the engineers will log into each client server and copy the release to the server and run the release script and the check that everything was successful. This can be tedious, clients can be forgotten, maybe the clients don't want people to access their servers...
- with `n8n` you can monitor a `GitHub` `Repo` and some actions can be performed if something happens that you are monitoring. So in this case n8n will be watching for new releases, everything time there is one, it will attempt download it and run the installation. It will get the results of the action and report back to my sever and make an entry for each client. It can send Slack messages or emails or whatsApps if there were any issues, it can auto rollback the software if needed, it can even make a phone call and tell you was a problem

Above is just one workflow which I think with some thought and fine tuning can be used for deploying any software to any client and all the `reporting` and `installations` will happen automatically

- Youtube: [https://www.youtube.com/watch?v=sJO3b0WXm8I](https://www.youtube.com/watch?v=sJO3b0WXm8I)
- Youtube: [https://www.youtube.com/watch?v=0V-UtIK_6oI&t=3s](https://www.youtube.com/watch?v=0V-UtIK_6oI&t=3s)
- Youtube: [https://www.youtube.com/watch?v=GbN-SnK5cy4](https://www.youtube.com/watch?v=GbN-SnK5cy4)

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
