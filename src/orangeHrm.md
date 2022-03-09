# Orange HRM

## What is Orange HRM

OrangeHRM provides a world-class HRIS experience and offers everything you and your team needs to be that HR hero you know that you are.

Whether you are trying to track PTO or hold performance reviews, you get all of the tools you need to shine. Thousands of businesses around the world are benefitting from OrangeHRM as their HR Management software.

### Install with Docker Composer and Portainer

- Open portainer
- Click on stacks
- New stack
- Give it a name
- paste the followoing in th compose block

```yml
version: '2'
services:
  mariadb:
    image: mariadb
    volumes:
      - /var/www/tools/Orangehrm:/var/lib/mysql
    environment:
      - MYSQL_ROOT_PASSWORD=changeme
      - MYSQL_ROOT_USER=root
      - MYSQL_DATABASE=orangehrm
      
  orangehrm:
    image: orangehrm/orangehrm:latest
    ports:
      - 8181:80
      - 8443:443
    environment:
      - ORANGEHRM_DATABASE_HOST=mariadb
      - ORANGEHRM_DATABASE_USER=root
      - ORANGEHRM_DATABASE_PASSWORD=changeme
      - ORANGEHRM_DATABASE_NAME=orangehrm
      - PUID=1000
      - PGID=1000
    volumes:
      - /srv/Configs/Orangehrm:/orangehrm
    depends_on:
      - mariadb
    links:
      - mariadb:mariadb
```
