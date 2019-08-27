<h1 align="center">Docfony</h1>
<h2 align="center">Docker Symfony Development Stack</h2>
<p align="center"><img src="https://travis-ci.org/neg0/docfony.svg?branch=master" alt="build:passed"></p>

* **PHP**   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;_7.4-RC_
* **NGINX** _1.17_
* **MySQL** _8.0_
* **Mongo** _4.0_
* **Redis** &nbsp;&nbsp;&nbsp;_5.0_

## Requirements 
* Operating Systems supported by Docker _<small>(Please checkout <a href="https://docs.docker.com/engine/installation/#supported-platforms" target="_blank">Supported platforms</a>)</small>_
* Docker version 17.x _<small>(Please visit <a href="https://www.docker.com/community-edition" target="_blank">Docker Community Edition</a>)</small>_
* Docker Compose should be enabled
* Symfony Framework 4+

## Download
Please ensure there is no similar service are running on the same ports on your host machine before 
start running the containers; after successfully cloning the repository, you should see a folder named **docfony**; 
please go inside the **docfony** and follow the rest of the document:

    $ git clone https://github.com/impixel/docfony.git
    $ cd docfony

> For Stable version; please download the archive version of latest stable release of
Docfony from Releases tab on Github

## Makefile
If you are novice to Docker, you could use `Makefile` to get your environment up and running by:

    $ make help

## Build Docker Images
In order to build the images and create the containers please run:

    $ make build
    $ make up

Docker daemon starts to download and build the required images to run your Symfony application. During process docker will create three virtual volumes for data presistency for both databases MySQL and Mongo:
* __docfony-dev-mysql__ _It will store MySQL Database data files from_ `/var/lib/mysql` 
* __docfony-dev-mongo__ _It will store Mongo Database data files from_ `/data/db`
* __docfony-dev-mongo-config__ _It will store Mongo Database config data from_ `/data/configdb`
* __docfony-dev-redis__ _It will store Redis data from_ `/data`

> For development purpose volume for Symfony application is shared with your machine (Host) and is accessible via folder outside of **docfony**, called **project**.
This shall become a virtual volume in production
In addition to virtual volumes, Docker will also creates a **network** with **bridge** driver
named `docfony_symfony_dev` to make the containers to communicate with each other

### Installation via Composer
Please execute make file at the root of Docfony as presented below:

    $ make php

to automatically enter inside the PHP container with tty access (bash), now you can install
your symfony application.

    root@2ecca:/var/www#: composer create-project symfony/skeleton project

>**Please Note** Project name must be `project` as illustrated above due to NGINX path configuration.

Composer will download the necessary packages for your Symfony application and now you can view the app via your browser from following URL:
`http://localhost`, you may also view your application via virtual host domain: `http://docfony.docker`
>**Please Note** you need to add `docfony.docker` assigned to `127.0.0.1`  on your host machine (Mac/Linux in /etc/hosts and for Windows via Firewall settings)

### Symfony Parameters, Hosts and Ports
Example of parameters being asked during Symfony installation below:
```yml
parameters:
    database_host: mysql
    database_port: 3308
    database_name: symfony
    database_user: root
    database_password: null
    mailer_transport: smtp
    mailer_host: php
    mailer_user: null
    mailer_password: null
    secret: f0379aa3b94f435c057060d21e7afb10
```
You may use GUI applications to manage your database by specifying `mysql` or `mongo` as a host
and specified port in `docker-compose.yml`. Please use following to connect to MySQL, Mongo Database
and Xdebug via your machine:

* __MySQL Database__
    * Host: _mysql_
    * Port: _3308_
* __Mongo Database__
    * Host: _mongo_
    * Port: _27017_
* __Xdebug__
    * Port: _9001_

> **Please Note** you may also use IP address `127.0.0.1` as a host for each service instead.


### Quit and remove the containers
In order to quit and remove containers run the following make command:

    $ make down


### Local Development
You can view and edit your codes via `project` folder outside of `docfony` and change
on your machine will be synchronised with running containers.

>**Please Note** make sure your containers are running while you are making changes to your project to ensure data persistency all across containers with the host machine


### Support and Help
If you found an issue, please use git issues to report and if you wish to contribute to this project feel free to fork and create a pull request to the develop branch
>_**Disclaimer:** Please don't use this to deploy in production, this project been built for Symfony enthusiasts to attract more contributors and prospect companies whom wish to give an enterprise level PHP Framework a quick try, without a worry of configuration and installation of required packages_


### Credits
Built with :heart: and maintained at beautiful London


### License
Regarding licensing and version of please visit: [Creative Commons License](https://creativecommons.org/licenses/by-sa/4.0/) or read through license file `LICENSE.md` included in the repository.

![CC Attribution-ShareAlike](https://licensebuttons.net/l/by-sa/3.0/88x31.png)
