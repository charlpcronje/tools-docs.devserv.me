# Some Productivity Tools & Tips

For some usages and uncommon command for software lie GIT etc, I created the following usages section.

- [Quick Tips](http://tips-docs.devserv.me)

I realized that I'm constantly trying to remember some server name or some port number or URL. Also working with the file system in the terminal is not always the nicest experience. Also accessing MySQL in the terminal is a waste of time. Managing Docker containers also gets old fast. To get past all of these frustrations I found a collection of tools that makes everything quick to access and for new users this will make a big difference.

- [Heimdal Dashboard](https://setup-docs.devserv.me/heimdal/)
- [Cockpit Server Management](https://setup-docs.devserv.me/cockpit)
- [Portainer Container Management](https://setup-docs.devserv.me/portainer)
- [AdMiner Web-Bases SQL Client](adminer.md)
- [Code Snippets](https://setup-docs.devserv.me/codesnippets)
- [Install Dillinger for MD](https://setup-docs.devserv.me/dillinger)
- [Install Double Commander](https://setup-docs.devserv.me/doublecommander)
- [Install Cloud Commander](https://setup-docs.devserv.me/cloudcommander)
- [Install Droppy File Manager](https://setup-docs.devserv.me/droppy)
- [rstudio.md](rstudio.md)
- [VS Code-Server](https://setup-docs.devserv.me/codeserverdocker)
- [Cloud9 IDE](https://setup-docs.devserv.me/cloud9)
- [Ice Coder](iceCoder.md)
- **[Scripts](scripts/README.md)**
  - [Service Menu](scripts/serviceMenu.md)
  - [Retype Build](retypeBuild.md)
  - [setWebPermissions](scripts/fixWebPermisions.md)
- [ReType](https://setup-docs.devserv.me/retype)
- [OrangeHRM](orangeHrm.md)
- [Install VmStat](vmstat.md)
- [Install htop](htop.md)
- [Install Munin](munin.md)
- [Install Dashboard](dashboard.md)

## Facial Recognition

- [Exadel CompreFace](exadelCompreFace.md)

## - [n8n Workflow Automation](n8n.md)

- `n8n` is a workflow automation tool and it can integrate with most public `API's`. The reason why I'm using it to `automate` the deployment of software every time a new release of my software is added to `GITHUB`
- A release of `GitHub` is not something that happens with every commit, a release is created specifically when you are ready with the new version of your software and it is ready to be shipped to your clients.
- In many cases the deploy process is manual, so the engineers will log into each client server and copy the release to the server and run the release script and the check that everything was successful. This can be tedious, clients can be forgotten, maybe the clients don't want people to access their servers...
- with `n8n` you can monitor a `GitHub` `Repo` and some actions can be performed if something happens that you are monitoring. So in this case n8n will be watching for new releases, everything time there is one, it will attempt download it and run the installation. It will get the results of the action and report back to my sever and make an entry for each client. It can send Slack messages or emails or whatsApps if there were any issues, it can auto rollback the software if needed, it can even make a phone call and tell you was a problem

Above is just one workflow which I think with some thought and fine tuning can be used for deploying any software to any client and all the `reporting` and `installations` will happen automatically

- Youtube: [https://www.youtube.com/watch?v=sJO3b0WXm8I](https://www.youtube.com/watch?v=sJO3b0WXm8I)
- Youtube: [https://www.youtube.com/watch?v=0V-UtIK_6oI&t=3s](https://www.youtube.com/watch?v=0V-UtIK_6oI&t=3s)
- Youtube: [https://www.youtube.com/watch?v=GbN-SnK5cy4](https://www.youtube.com/watch?v=GbN-SnK5cy4)
