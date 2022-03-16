# Create Docker Image of ReportServer

Jasper server is shipped with `postgresql` and `tomcat` which allows to connect other database servers like `mysql`, `oracle`, `DB2` and SQL server and connect other application servers like `JBoss`. Jasper server installation allows to connect an existing postgresql server and a `tomcat` server. This article is a detailed explanation of Jasper server installation on docker. This installation leverages an existing `tomcat` server image and a `postgresql` image which were created on `docker`.

## Initiation of database service

The first step is to create the `postgresql` image and start database service from an exisiting `postgresql` (postgresql 10.1) image on `docker` hub. To start an application’s services you can write a `docker-compose.yml` file. The `docker-compose.yml` file that is shown below.

```yml
version: '3'
services:
  jasperserver:
    image: jasperserver-pro:latest
    container_name: jasperserver
    # expose port 8080 and bind it to 8080 on host
    ports:
      - "8080:8080"
    # depends on js_db service
    depends_on:
      - js_db
    # point to env file with key=value entries
    env_file: env
    # following values will override settings from env_file
    environment:
      - DB_HOST=js_db
  js_db:
    image: postgres:10.1
    container_name: pgtest
    ports:
      - "5432:5432"
    volumes:
      - ./postgres-data:/var/lib/postgresql/data
    env_file: env
```

You can mount the data to the host machine as a volume which secures your valuable data using volumes attribute.

```yml
  js_db:
    image: postgres:10.1
    container_name: pgtest
    ports:
      - "5432:5432"
    volumes:
      - ./postgres-data:/var/lib/postgresql/data
    env_file: env
```

The `env` file defines the corresponding environment variables as follows.

```conf
# user, password and other details for JasperReports Server
DB_USER=postgres
DB_PASSWORD=password
DB_PORT=5432
DB_NAME=jasperserverdb
# these variables are required by PostgreSQL container
POSTGRES_USER=postgres
POSTGRES_PASSWORD=password
```

Alternatively you can use environment attribute in `docker-compose.yml` file to declare the values for the above environment variables as follows.

```yml
  js_db:
    image: postgres:10.1
    container_name: pgtest
    ports:
      - "5432:5432"
    volumes:
      - ./postgres-data:/var/lib/postgresql/data
    environment:
      - DB_HOST=jasperdb
      - DB_USER=postgres
      - DB_PASSWORD=password
      - DB_PORT=5432
      - DB_NAME=jasperserverdb
```

## Initiation of Jasper service

A `Jasper image` has been created on a `tomcat` image and the Jasper image is reused to start the `Jasper` service by adding the following set of lines to the `docker-compose.yml` file.

```yml
  jasperserver:
    image: jasperserver-pro:latest
    container_name: jasperserver
    # expose port 8080 and bind it to 8080 on host
    ports:
      - "8080:8080"
    # depends on js_db service
    depends_on:
      - js_db
    # point to env file with key=value entries
    env_file: env
    # following values will override settings from env_file
    environment:
      - DB_HOST=js_db
```

Here `jasperserver-pro:latest` is the latest version of Jasper image that have been created locally. Let’s see how to create the jasper image locally.

## Creation of Tomcat image

In order to create an image of the Jasper reporting server you need to create a Docker file which illustrates the requirements, environment variables and deployment steps of the server. `Jasper` server image uses customised `tomcat` image as the base image. It’s very easy to create your own `tomcat` image by adding the following set of lines to a file called Dockerfile which is used by docker to create the particular image.

```yml
FROM java:latest
MAINTAINER John Doe <john.doe@gmail.com>
ENV TOMCAT_MAJOR=8 \
    TOMCAT_VERSION=8.5.24
ENV CATALINA_HOME /opt/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
#ENV TOMCAT_TGZ_URL https://www.apache.org/dist/tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz
COPY /resources/apache-tomcat-${TOMCAT_VERSION}.tar.gz /opt/
RUN tar -xvf /opt/apache-tomcat-${TOMCAT_VERSION}.tar.gz --directory /opt/ && \
    mv /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat
EXPOSE 8080
CMD ["catalina.sh","run"]
```

Here a local `java` image has been used in this example. You can use a `java` image from `dockerhub` by downloading the image. The important thing is you need to create a resources folder in the directory where you created the Dockerfile and place the downloded tar.gz file of apache tomcat there which is copied in to the docker image. The default port that is exposed for tomcat is 8080 which can be configurable accordingly.

To create the tomcat docker image you need to build the Dockerfile using the following command.

```sh
docker build -t tomcat
```

`tomcat` is the tag name used to reference later when running the tomcat image and `.` is used to tell where to find the Dockerfile to build. Here it is the same place where build command is running.

![st](https://miro.medium.com/max/890/1*yEUPhXqsBgRcp9_E2jTbcg.jpeg)

If you really want to test the images separately, you can run them and test using the following command.

```sh
docker run -d -it -p 8090:8080 --name=tomcat_container tomcat
```

Here `-p 8090:8080` maps `8090` port of the host machine to `8080` post of `tomcat` container. `tomcat` is the tag name of the `tomcat` image we used in build and you can provide any name for the container that would be created.

## Creation of Jasper image

Now you can create the Jasper image using the above created `tomcat` base image.

```sh
from tomcat:latest
MAINTAINER John Doe <john.doe@gmail.com>
ENV JASPER_VERSION=6.4.0
RUN yum update -y && \
 yum install -y unzip && \
 yum clean all
COPY /resources/TIB_js-jrs_6.4.0_bin.zip /opt/
RUN unzip /opt/TIB_js-jrs_6.4.0_bin.zip -d /opt/ && \
    rm /opt/TIB_js-jrs_6.4.0_bin.zip && \
    mv /opt/jasperreports-server-pro-6.4.0-bin /opt/jasperserver-pro
COPY /resources/default_master.properties /opt/jasperserver-pro/buildomatic/
#Change working directory
WORKDIR /opt/jasperserver-pro/buildomatic
ENV ANT_HOME /opt/jasperserver-pro/apache-ant
ENV PATH $ANT_HOME/bin:$PATH
#Installs JasperReports Server and jasperserver database
RUN ./js-install.sh
#Copy the license file
COPY /resources/jasperserver.license /root
#Change working directory
WORKDIR /opt/tomcat/bin
EXPOSE 8080
CMD ["catalina.sh","run"]
```

Create a resources folder inside the directory you are creating the Dockerfile. The Dockerfiles for `tomcat` and Jasper should be in two different directories. Download `TIB_js-jrs_6.4.0_bin.zip` and add it to the resources folder. There’s a properties file called default_master.properties in unzipped jasperreports-server-pro-6.4.0-bin/buildomatic. Edit the following lines and add the properties file to resources folder.

```conf
# database type
dbType=postgresql
# database location and connection settings
dbHost=docker.for.mac.localhost
dbUsername=postgres
dbPassword=password
# additional database parameters
# (uncomment these if you want non-default settings)
dbPort=5432
# JasperServer db name, sample db names
js.dbName=jasperserverdb
```

Here a locally running database on a mac device is used so, `dbHost=docker.for.mac.localhost`. Configure the properties as required.
To build the Jasper server image use the following command.

```sh
docker build -t jasperserver
```

Now you are ready to run both postgres database service and Jasper reporting service for your application. Simply take a terminal and navigate to the folder where you created the `docker-compose.yml` file and run the follwoing command. This will create containers for both postgres and Jasper.

```sh
docker-compose up
```

You can view the created `docker` containers by running the following command.

```sh
docker ps
```

To stop services and remove containers you can use the following command.

```sh
docker-compose down
```

If you want to log into any of the `docker` containers that you have created, you can use the following command.

```sh
docker exec -it pgtest /bin/sh
```

Now that the `Jasper reporting server` is up in a `docker` container you can access the server via the exposed port. In this example since the exposed port is `8080` and if the commercial edition of the server is used you can access server with [http://localhost:8080/jasperserver-pro/](http://localhost:8080/jasperserver-pro/).

![img2](https://miro.medium.com/max/1400/1*rsvii81Ra9zS7DV8Hvjshg.png)

Please add a comment if you want to raise any question. Hope you will quickly get started with docker and dig deeper.
Further reading:

1. [https://docs.docker.com/compose/gettingstarted/]([https://docs.docker.com/compose/gettingstarted/)
2. [https://docs.docker.com/engine/reference/builder/](https://docs.docker.com/engine/reference/builder/)
3. [https://docs.docker.com/develop/develop-images/dockerfile_best-practices/](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)