---
title: Daptin
---
<script type="text/javascript">(function(w,s){var e=document.createElement("script");e.type="text/javascript";e.async=true;e.src="https://cdn.pagesense.io/js/webally/f2527eebee974243853bcd47b32631f4.js";var x=document.getElementsByTagName("script")[0];x.parentNode.insertBefore(e,x);})(window,"script");</script>

A modern backend for application developers and testers in the mobile era.

**Daptin** is an open-source backend development framework to develop and deploy production-ready JSON API based applications. With Daptin you can design your data model and have a production ready JSON API online in minutes.

By following shared conventions, you can increase productivity, take advantage of generalized tooling, and focus on what matters: your application.

Easily consume the following features on any device

- Relations databased backed persistent data exposed as a **JSON API**
- User registration and login **API**
- Social login with oauth2: tested with google, github, linkedin
- Special State management **APIs**
- Install **API** Package from Market place selectively enabling a variety of features
- Sync with **cloud storage services** like gdrive, dropbox, b2, s3 and more
- Manage multiple static websites under separate sub-domain/sub-paths
- Connect with other services by directly connecting with any external API
- **Database** to easily evolves your data schema & migrates your database [Postgres/MySQL/SQLite]
- **Flexible auth** using the JWT-based authentication & permission system
- **Works with all frontend frameworks** like React, Vue.js, Angular, Android, iOS
- **Very low memory requirement** and horizontally scalable
- **Can be deployed on a wide range of hardware** arm5,arm6,arm7,arm64,mips,mips64,mips64le,mipsle (or build for your target using go)

## Deploy and get started


| Deployment preference	       |  Getting started                                                                   |
|------------------------------|------------------------------------------------------------------------------------|
| Heroku	                   | [Deploy](https://heroku.com/deploy?template=https://github.com/daptin/daptin)      |
| Docker	                   | `docker run -p 8080:8080 daptin/daptin`                                            |
| Kubernetes	               | [Service & Deployment YAML](https://docs.dapt.in/setting-up/settingup/#kubernetes) |
| Local	                       | `go get github.com/daptin/daptin`                                                  |
| Linux (386/amd64/arm5,6,7)   | [Download static linux builds](https://github.com/daptin/daptin/releases)          |
| Windows	                   | `go get github.com/daptin/daptin`                                                  |
| OS X	                       | `go get github.com/daptin/daptin`                                                  |
| Load testing	               | [Docker compose](https://docs.dapt.in/setting-up/settingup/#docker-compose)        |
| Raspberry Pi	               | [Linux arm 7 static build](https://github.com/daptin/daptin/releases)              |

![img1](https://raw.githubusercontent.com/daptin/daptin/master/docs_markdown/docs/gifs/signup_and_signin.gif)

