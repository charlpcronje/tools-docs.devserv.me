# Paperwork

- Dockerfile for Paperwork with embedded MariaDB (MySQL) Database
- Open Source note-taking & archiving alternative to Evernote, Microsoft OneNote & Google Keep

To install Paperwork is very simple. Note: you do need Docker installed on your system before you follow these instructions

## Installation

Run the following command

```sh
docker pull zuhkov/paperwork
```

=== Running

> Create your Paperwork config directory (which will contain both the properties file and the database) and then launch with the following:

```sh
docker run -d -v /your-config-location:/config -p 8888:80 zuhkov/paperwork
```

Browse to `http://your-host-ip:8888` and login with user and password paperwork

===
