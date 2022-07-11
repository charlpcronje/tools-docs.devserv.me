---
title: Self Host appSmith
---
<script type="text/javascript">(function(w,s){var e=document.createElement("script");e.type="text/javascript";e.async=true;e.src="https://cdn.pagesense.io/js/webally/f2527eebee974243853bcd47b32631f4.js";var x=document.getElementsByTagName("script")[0];x.parentNode.insertBefore(e,x);})(window,"script");</script>

!!! 
Easiest way is with Docker 
!!!

## Download docker-compose.yml

```sh
curl -L https://bit.ly/32jBNin -o $PWD/docker-compose.yml
```

- This configuration runs an `AppSmith` instance and a Watchtower instance to keep Appsmith automatically up-to-date.
- Bring the docker container up by running the following command. (You may need to run as sudo if docker and docker-compose are not accessible by your user)

```sh
docker-compose up -d
```

- IF not already locally available, this command will download the Docker images and start the services. You can follow the logs with the following command:

```sh
docker logs -f appsmith
```

- You should see a message Appsmith is Running! once the container is ready
- Congratulations! Your Appsmith server should be up and running now. You can access it at `http://localhost`.

## Updating Appsmith (with docker-compose)

To update Appsmith (configured with docker-compose) manually, go to the root directory of your setup and run the following commands:

```sh
docker-compose pull
docker-compose rm -fsv appsmith
docker-compose up -d
```

## Explore Appsmith (without docker-compose)

To quickly get Appsmith up and running, run the following command on your machine:

```sh
docker run -d --name appsmith -p 80:80 -p 9001:9001 -v "$PWD/stacks:/appsmith-stacks" appsmith/appsmith-ce
```

- This command will download the image and start Appsmith. Once the download is complete, the server should be up in under a minute. You can follow the logs with the following command:

```sh
docker logs -f appsmith
```

- You should see a message Appsmith is Running! once the container is ready

## Restarting Containers

If your containers are failing to restart, you can execute the below script to bring them up:

copy the script to your installation folder and make it executable

```sh
chmod +x restart-containers.sh
./restart-containers.sh
```

## Updating Appsmith (without docker-compose)

To update Appsmith manually, go to the root directory of your setup and run the following commands:

```sh
docker rmi appsmith/appsmith-ce -f
docker pull appsmith/appsmith-ce
docker rm -f appsmith
docker run -d --name appsmith -p 80:80 -p 9001:9001 -v "$PWD/stacks:/appsmith-stacks" appsmith/appsmith-ce
```