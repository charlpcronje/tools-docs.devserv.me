# Exadel CompreFace is a leading free and open-source face recognition system

![Exadel CompreFace](https://user-images.githubusercontent.com/3736126/147130206-17234c47-8d40-490f-8d93-57014fa6d87e.png)

Exadel CompreFace is a free and open-source face recognition service that can be easily integrated into any system without prior machine learning skills. CompreFace provides REST API for face recognition, face verification, face detection, landmark detection, age, and gender recognition and is easily deployed with docker.

## [Official website](https://exadel.com/solutions/compreface/)

- Exadel CompreFace is a leading free and open-source face recognition system

## Table Of Contents

- [Documentation](https://github.com/exadel-inc/CompreFace/docs)
- [How to Use CompreFace](https://github.com/exadel-inc/CompreFace/docs/How-to-Use-CompreFace.md)
- [Face Services and Plugins](https://github.com/exadel-inc/CompreFace/docs/Face-services-and-plugins.md)
- [Rest API Description](https://github.com/exadel-inc/CompreFace/docs/Rest-API-description.md)
- [Postman documentation and collection](https://documenter.getpostman.com/view/17578263/UUxzAnde)
- [Face Recognition Similarity Threshold](https://github.com/exadel-inc/CompreFace/docs/Face-Recognition-Similarity-Threshold.md)
- [Configuration](https://github.com/exadel-inc/CompreFace/docs/Configuration.md)
- [Architecture and Scalability](https://github.com/exadel-inc/CompreFace/docs/Architecture-and-scalability.md)
- [Custom Builds](https://github.com/exadel-inc/CompreFace/docs/Custom-builds.md)
- [Face data migration](https://github.com/exadel-inc/CompreFace/docs/Face-data-migration.md)
- [User Roles System](https://github.com/exadel-inc/CompreFace/docs/User-Roles-System.md)
- [Face Mask Detection Plugin](https://github.com/exadel-inc/CompreFace/docs/Mask-detection-plugin.md)
- [Kubernetes configuration](https://github.com/exadel-inc/compreface-kubernetes)
- [Gathering Anonymous Statistics](https://github.com/exadel-inc/CompreFace/docs/Gathering-anonymous-statistics.md)
- [Installation Options](https://github.com/exadel-inc/CompreFace/docs/Installation-options.md)

## Overview

Exadel CompreFace is a free and open-source face recognition GitHub project.
Essentially, it is a docker-based application that can be used as a standalone server or deployed in the cloud.
You don't need prior machine learning skills to set up and use CompreFace.

The system provides REST API for face recognition, face verification, face detection, landmark detection, age, and gender recognition.
The solution also features a role management system that allows you to easily control who has access to your Face Recognition Services.

CompreFace is delivered as a docker-compose config and supports different models that work on CPU and GPU.
Our solution is based on state-of-the-art methods and libraries like FaceNet and InsightFace.

## News and updates

[Subscribe](https://info.exadel.com/en/compreface-news-and-updates) to CompreFace News and Updates to never miss new features and product improvements.

## Features

The system can accurately identify people even when it has only “seen” their photo once. Technology-wise, CompreFace has several advantages over similar free face recognition solutions. CompreFace:

- Supports both CPU and GPU and is easy to scale up
- Is open source and self-hosted, which gives you additional guarantees for data security
- Can be deployed either in the cloud or on premises
- Can be set up and used without machine learning expertise
- Uses FaceNet and InsightFace libraries, which use state-of-the-art face recognition methods
- Starts quickly with just one docker command

## Functionalities

- Supports many face recognition services:

- [face detection](https://github.com/exadel-inc/CompreFace/blob/master/docs/Face-services-and-plugins.md#face-detection)
- [face recognition](https://github.com/exadel-inc/CompreFace/blob/master/docs/Face-services-and-plugins.md#face-recognition)
- [face verification](https://github.com/exadel-inc/CompreFace/blob/master/docs/Face-services-and-plugins.md#face-verification)
- [landmark detection plugin](https://github.com/exadel-inc/CompreFace/blob/master/docs/Face-services-and-plugins.md#face-plugins)
- [age recognition plugin](https://github.com/exadel-inc/CompreFace/blob/master/docs/Face-services-and-plugins.md#face-plugins)
- [gender recognition plugin](https://github.com/exadel-inc/CompreFace/blob/master/docs/Face-services-and-plugins.md#face-pluginss)
- [face mask detection plugin](https://github.com/exadel-inc/CompreFace/blob/master/docs/Face-services-and-plugins.md#face-pluginss)

- Use the CompreFace UI panel for convenient user roles and access management

## Getting Started with CompreFace

### Requirements

1. Docker and Docker compose (or Docker Desktop)
2. CompreFace could be run on most modern computers with [x86 processor](https://en.wikipedia.org/wiki/X86) and [AVX support](https://en.wikipedia.org/wiki/Advanced_Vector_Extensions).
   To check AVX support on Linux run `lscpu | grep avx` command

### To get started (Linux, MacOS)

1. Install Docker and Docker Compose
2. Download the archive from our latest release: `https://github.com/exadel-inc/CompreFace/releases`
3. Unzip the archive
4. Open the terminal in this folder and run this command: `docker-compose up -d`
5. Open the service in your browser: `http://localhost:8000/login`

### To get started (Windows)

1. Install Docker Desktop
2. Download the archive from our latest release: `https://github.com/exadel-inc/CompreFace/releases`
3. Unzip the archive
4. Run Docker
5. Open Command prompt (write `cmd` in windows search bar)
6. Open folder where you extracted zip archive (Write `cd path_of_the_folder`, press enter).
7. Run command: `docker-compose up -d`
8. Open `http://localhost:8000/login`

### CompreFace SDKs

| SDK        | Repository                                                |
|------------|-----------------------------------------------------------|
| JavaScript | `https://github.com/exadel-inc/compreface-javascript-sdk` |
| Python     | `https://github.com/exadel-inc/compreface-python-sdk`     |
