# tools.docs.CRONje.ME

Tools I setup and tested on development server

- This is the docs for installing all the tools running on development server
- Check out the [src/README.md](src/README.md) file for the actual index of this docs repo
- The actual docs is in the `src/` directory and is written to be compiled by [https://retype.com](https://retype.com)
- Retype is an ✨ ultra-high-performance ✨ generator that builds a website based on simple text files. Focus on your writing while Retype builds the rest.
- The retype.com website was generated using Retype. View the source used to generate this very page.
- A new Retype powered website can be up and running within seconds once Retype is installed, which itself takes only a few seconds. 👍

## Quick start  0659117821

- You can install Retype using npm, yarn, or the dotnet CLI.
- From your command line, navigate to a folder location where you have one or more Markdown .md files, such as a GitHub project.
- Next, choose one of the following tools to first install retypeapp and then start Retype by using the retype watch command:

```sh
npm install retypeapp --global
retype watch
```

> You will require either [`npm`](https://setup.docs.CRONje.ME/node/), `Yarn`, or the `dotnet CLI` to be installed before installing Retype. Only one of those three is required, although all three could be installed on your machine too. It's up to you. 🙌

__All operating systems are supported, including `Mac`, `Windows`, and `Linux`.__

## Live reload

- If a change is detected, such as editing and saving an .md file, your Retype website will be updated almost instantly within the browser.
- The retype watch command runs the following three commands and listens for any new changes in your content.

```sh
retype init
retype build
retype run
```

After running retype watch, edit any `.md` file and see your change appear in the browser.

