# Retype Build

Retype is a static site generator for markdown docs. [More info](https://setup-docs.devserv.me/retype)

For my builds I use this Yaml template:

## Yaml template

```yml
# Retype.yml
input: src
output: public
url: https://tools-docs.devserv.me
branding:
  title: DEVserv.ME Tools
  label: Docs
links:
- text: DEVserv.ME Docs
  link: https://docs.devserv.me
- text: Charl Cronje
  link: https://charl-cv.devserv.me
- text: DEVserv.ME Dashboard
  link: https://oz.devserv.me
footer:
  copyright: "webAlly &copy; Copyright {{ year }}. All rights reserved."
```

Every set of documents have this folder structure:

## Folder Structure

```sh
retype.yml (Docs root folder folder)
|- src
|- public
|- logs
```

In the `srv/scripts` folder there is a `retype.sh` file with the following content:

```sh
retype build
```

Then I created a Symbolic link link to `/usr/bin/rt` so when I need to recompile the docs in a folder I `cd` to the docs root folder and enter command

```sh
rt
```

This might only save me 2 seconds but it just feels like so much less hassle and less to remember, In a way this automated the process in a way, because I know there is only one step and what it's done compiling I have the peace of mind that I did not forget anything.
