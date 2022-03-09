# OliveTin

OliveTin gives safe and simple access to predefined shell commands from a web interface.

- Visit [https://docs.olivetin.app/choose-package.html](https://docs.olivetin.app/choose-package.html) to choose package the package for your OS

For my server CentOS 7 the choose the following RPM: [https://github.com/OliveTin/OliveTin/releases/download/2022-01-06/OliveTin_2022-01-06_linux_amd64.rpm](https://github.com/OliveTin/OliveTin/releases/download/2022-01-06/OliveTin_2022-01-06_linux_amd64.rpm)

Execute the following commands to install

```sh
wget https://github.com/OliveTin/OliveTin/releases/download/2022-01-06/OliveTin_2022-01-06_linux_amd64.rpm
rpm -i OliveTin_2022-01-06_linux_amd64.rpm
systemctl enable --now OliveTin
```

To check that OliveTin is running

```sh
systemctl enable --now OliveTin
```

- OliveTin runs on Port `1337`, I use `NginX Proxy Manager` to point a sub-domain to a port number
- You will need to write a basic configuration file before OliveTin will startup.
- Create the following basic config file at `/etc/OliveTin/config.yaml` with the following contents

```yml
actions:
  - title: "Hello world!"
    shell: echo 'Hello World!'
```

Visit: [https://docs.olivetin.app/action-customisation.html](https://docs.olivetin.app/action-customisation.html) for full actions guide

