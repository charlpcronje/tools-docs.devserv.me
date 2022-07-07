# focalboard Docker Install

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

