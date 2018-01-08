# Docfony - Docker Symfony 3.x
![continuousphp](https://img.shields.io/continuousphp/git-hub/doctrine/dbal/master.svg) [![Read the Docs (version)](https://img.shields.io/readthedocs/pip/stable.svg)]()
* **PHP** _version 7.2_
* **NGINX** _version 1.13_
* **Apache (httpd)** _version 2.4_
* **MySQL** _version 5.7_
* **Mongo** _version 3.4_

## Requirements 
* Operating Systems supported by Docker _<small>(Please checkout <a href="https://docs.docker.com/engine/installation/#supported-platforms" target="_blank">Supported platforms</a>)</small>_
* Docker version 17.x _<small>(Please visit <a href="https://www.docker.com/community-edition" target="_blank">Docker Community Edition</a>)</small>_
* Docker Compose  should be enabled
* Symfony Framework 3.x

### Download and Installation
Please ensure there is no similar service are running on the same ports on your host machine before start running the containers; after successfully cloning the repository, you should see a folder named **docfony**; please go inside the **docfony** and run `docker-compose` as below:
```bash
$ git clone https://github.com/impixel/docfony.git
$ cd docfony
$ docker-compose up
```
Docker daemon starts to download and build the required images to run your Symfony application. During process docker will create three virtual volumes for data presistency for both databases MySQL and Mongo:
* __docfony-dev-mysql__ _It will store MySQL Database data files from_ `/var/lib/mysql` 
* __docfony-dev-mongo__ _It will store Mongo Database data files from_ `/data/db`
* __docfony-dev-mongo-config__ _It will store Mongo Database config data from_ `/data/configdb`

However for development purpose volume for Symfony application is shared with your machine (Host) and is accessible via folder outside of **docfony**, called **project**.

>In addition to virtual volumes, Docker will also creates a **network** with **bridge** driver named `docfony_symfony_dev` to make the containers to communicate with each other

After successfully pulling and building the images required, you can see the log messages appearing on your terminal, please open a new terminal tab and connect to the **php** container to download and install your Symfony application as below:
```bash
$ docker-compose exec php /bin/bash
root@d38cf:/var/www# composer create-project symfony/framework-standard-edition symfony_app 3.4
root@d38cf:/var/www# exit
```
>**Please Note** Project name must be `symfony_app` as illustrated above due to NGINX path configuration.

Composer will download the necessary packages for your Symfony application and now you can view the app via your browser from following URL:
`http://localhost`, you may also view your application via virtual host domain: `http://docfony.docker`
>**Please Note** you need to add `docfony.docker` assigned to `127.0.0.1`  on your host machine (Mac/Linux in /etc/hosts and for Windows via Firewall settings)

### NGINX and Apache (httpd)
You can use both web servers to serve your symfony application, by default NGINX uses port `80` and Apache is accessible via port `8080` as below:
```bash
http://localhost:80
http://localhost:8080
```

### Symfony Parameters, Hosts and Ports
Example of parameters being asked during Symfony installation below:
```yml
parameters:
    database_host: mysql
    database_port: 3306
    database_name: symfony
    database_user: root
    database_password: null
    mailer_transport: smtp
    mailer_host: php
    mailer_user: null
    mailer_password: null
    secret: f0379aa3b94f435c057060d21e7afb10
```
You may use GUI applications to manage your database by specifying `mysql` or `mongo` as a host and specified port in `docker-compose.yml`. Please use following to connect to MySQL, Mongo Database and Xdebug via your machine:

* __MySQL Database__
    * Host: _mysql_
    * Port: _3306_
* __Mongo Database__
    * Host: _mongo_
    * Port: _27017_
* __Xdebug__
    * Port: _9001_

> **Please Note** you may also use IP address `127.0.0.1` as a host for each service instead.

### Local Development
You can view and edit your codes via `project` folder outside of `docfony` and change on your machine will be synchronised with running containers.
>**Please Note** make sure your containers are running while you are making changes to your project to ensure data persistency all across containers with the host machine 

>:apple: **Mac User Only** please edit the `docker-compose.yml` and add `:cached` at the end of shared volume, like an example below:
```yml
volumes:
  - '../project:/var/www:cached'
```
### Re-Activate Symfony Debug Feature
Now you may navigate to `project/symfony_app/web/app_dev.php` and edit line 15, you should see an array of `['127.0.0.1', '::1']`, which should be extended further by adding network Gateway IP address `172.25.0.1`. To see if debug toolbar appears or you can see development feature of symfony, please navigate to the following via your browser: `http://localhots/app_dev.php`.
In order to find your Gateway IP address _(This IP address should be: 172.25.0.1 as specified in the compose file)_, please run the following:
```bash
$ docker network inspect docfony_symfony_dev --format="{{json .IPAM.Config}}"
```
```bash
[{"Subnet":"172.25.0.0/16","Gateway":"172.25.0.1"}]
```

### Activating Xdebug
By default I thought I could use Gateway IP address as `remote_host` for all operating systems 
but since it caused an issue for Mac OS after a brief research in docker forums, I found an 
answer that actually worked, please add IP address `10.254.254.254` to create an alias for your 
Mac loop-back interface by running the command below:
```bash
$ sudo ifconfig en0 alias 10.254.254.254 255.255.255.0
```
and now you could start your remote debug session via browser: `http://docfony.docker/?XDEBUG_SESSION_START` or `http://localhost/?XDEBUG_SESSION_START`

### Docker Cheatsheet
I have listed few commands you might find useful if you don't have much experience working with Docker below.

```bash
$ docker-compose up -d
```
_Adding flag `-d` will make `docker-compose` to run containers in the background_

```bash
$ docker-compose logs
```
_It will displays logs in case containers running on detach mode_

```bash
$ docker-compose ps
```
_It will display the status of running containers_

```bash
$ docker-compose down
```
_It should be used to terminate the process of containers_

```bash
$ docker-compose build
```
_If an error occurs during build or pulling images, you can continue the process again with `build` command_

### Support and Help
If you found an issue, please use git issues to report and if you wish to contribute to this project feel free to fork and create a pull request to the develop branch
>_**Disclaimer:** Please don't use this to deploy in production, this project been built for Symfony enthusiasts to attract more contributors and prospect companies whom wish to give an enterprise level PHP Framework a quick try, without a worry of configuration and installation of all required packages_
