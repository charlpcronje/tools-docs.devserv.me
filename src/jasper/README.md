# Jasper ReportServer

Before installing any package it is recommended that you update the packages and repository using the following command.

```sh
yum -y update
```
## Manual Install

1. [Install Java](https://setup.docs.CRONje.ME/java/)
2. [Other Java Web / Application Servers](otherJavaServers.md)
3. [Install Tomcat Server](https://setup.docs.CRONje.ME/tomcat/)
4. [Install PostgreSQL](https://setup.docs.CRONje.ME/postgresql/)
5. [Install ReportServer](reportServer.md)
6. [Create Docker Image](docker.md)
7. [Other Install options](otherInstallOptions.md)
8. [Supported Tech](supportedTech.md)
9. [Install Should Resemble](exampleInstallStructure.md)
10. [Edit Config Files](editConfigFiles.md)
11. [Restart Server with Dependencies](restartWithDependencies.md)
12. [Sign-In to ReportServer](signInReportServer.md)
13. [Troubleshooting](help.md)

- [Dr. Jaspersoft - Installing the war file distribution](https://www.youtube.com/watch?v=Pr89e_rKS2g)
- [Jaspersoft Server for Containers](https://github.com/TIBCOSoftware/js-docker/tree/main/jaspersoft-containers)
  - [Why use containers](https://www.youtube.com/watch?v=bLQNMjpQlaw)
  - [Deploy Jasper Server Using Docker](https://www.youtube.com/watch?v=T3_4WhEFtn4)
  - [JasperReports packaged by Bitnami](https://hub.docker.com/r/bitnami/jasperreports/)
  - [Jasper Server Community Edition on Docker](https://stackoverflow.com/questions/59413137/jasper-server-community-edition-on-docker)
  - [Dr. Jaspersoft - Docker & Kubernetes Deployment with JasperReports Server](https://www.youtube.com/watch?v=bLQNMjpQlaw)
- [Jaspersoft Server for AWS](https://www.jaspersoft.com/resources/community/jasperreports-server-aws-quickstart)
- More help can be found with the [Jasper Community](https://community.jaspersoft.com/documentation)
- [Youtube Install Guide](https://www.youtube.com/watch?v=Pr89e_rKS2g&t=694s)


## Reporting Tips

- [JasperQL - A New Query Language For Domain-Based Reports](https://www.youtube.com/watch?v=BE_Tec8MRwE)
- [Visualize.js: An Introduction](https://www.youtube.com/watch?v=W4CvPmSnOQs)
- [Visualize.js: Embedding a Data Visualization or Report](https://www.youtube.com/watch?v=xGbcQb1N-gU)
- [Visualize.js: Embedding a Report with Parameters](https://www.youtube.com/watch?v=_VoM7OYkcNQ)
- [How to Build Jaspersoft Dashboards from Impala (Hadoop)](https://www.youtube.com/watch?v=EzgtIjahIaI)
- [Jaspersoft Studio - Create Connection With Mysql](https://www.youtube.com/watch?v=-eg-t35eAYU)

## Customizing Jasper Report Server

The system is open source and there is a big community of developers out there adding new features. Before editing the system itself, first have a look at the xml files. The xml files have a lot of settings that can be adjusted.
Also the JavaScript files are minified but the un-minified versions are there as well.

- **XML**
  - Mostly config files
  - Can affect the UI
  - Require server restart to take affect
- JavaScript / html
  - Mostly for UI Changes
  - [Customizing the JavaScript](customizingJavaScript.md)