# Docfony - Docker Symfony 3.x
* **PHP** _version 7.1_
* **NGINX** _version 1.13_
* **MySQL** _version 5.7_
* **Mongo** _version 3.4_

## Requirements 
* Operating Systems supported by Docker _<small>(Please checkout <a href="https://docs.docker.com/engine/installation/#supported-platforms" target="_blank">Supported platforms</a>)</small>_
* Docker version 17.x _<small>(Please visit <a href="https://www.docker.com/community-edition" target="_blank">Docker Community Edition</a>)</small>_
* Docker Compose  should be enabled
* Symfony Framework 3.x

### Download and Installation
Please ensure there is no PHP-FPM, Apache (httpd) or NGINX is running on your machine before start running the containers; after successfully cloning the repository, you should see a folder named **docfony**; please go inside the **docfony** and run ```docke-compose``` as below:
```terminal
$ git clone https://github.com/impixel/docfony.git
$ cd docfony
$ docker-compose up
```
Docker daemon starts to download and build the required images to run your Symfony application. During process docker will create two virtual volumes for data presistency for both databases MySQL and Mongo:
* __docfony-dev-mysql__ _It will store MySQL Database data files from_ ```/var/lib/mysql``` 
* __docfony-dev-mongo__ _It will store Mongo Database data files from_ ```/data```

However for development purpose volume for Symfony application is shared with your machine (Host) and is accessible via folder outside of **docfony**, called **project**.

>In addition to virtual volumes, Docker will also creates a **network** with **bridge** driver named ```docfony-symfony-dev``` to make the containers to communicate with each other

After successfully pulling and building the images required, you can see the log messages appearing on your terminal, please open a new terminal tab and connect to the **php** container to download and install your Symfony application as below:
```terminal
$ docker-compose exec php /bin/bash
root@d38cf:/var/www# composer create-project symfony/framework-standard-edition symfony_app 3.4
```
>**Please Note** Project name must be ```symfony_app``` as illustrated above due to NGINX path configuration.

Composer will download the necessary packages for your Symfony application and now you can view the app via your browser from following URL:
```http://localhost ```, you may also view your application via virtual host domain: ```http://docfony.dev```
>**Please Note** you need to add ```docfony.dev``` assigned to ```127.0.0.1```  on your host machine (Mac/Linux in /etc/hosts and for Windows via Firewall settings)

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
    secret: 18A05C51097179AA4739E0C216C49AD02727C1BD
```
You may use GUI applications to manage your database by specifying ```mysql``` or ```mongo``` as a host and specified port in ```docker-compose.yml```, please use following to connect to MySQL and Mongo Database via your machine:

* __MySQL Database__
    * Host: _mysql_
    * Port: _3306_
* __Mongo Database__
    * Host: _mongo_
    * Port: _27017_

> **Please Note** you may also use actual IP address of each container using ```docker network inspect```, but this require more knowledge about Docker Networking; However, we discuss inspection later on for enabling Symfony debug features

### Local Development
You can view and edit your codes via ```project``` folder outside of ```docfony``` and change on your machine will be synchronised with running containers.
>**Please Note** make sure your containers are running while you are making changes to your project to ensure data presistency all across containers with the host machine 

### Re-Activate Symfony Debug Feature
In order to find your Gateway IP address, please run the following:
```terminal
$ docker network inspect docfony_symfony_dev --format="{{json .IPAM.Config}}"
[{"Subnet":"172.23.0.0/16","Gateway":"172.23.0.1"}]
```
Now you may navigate to ```project/symfony_app/web/app_dev.php``` and edit line 15, you should see an array of ```['127.0.0.1', '::1']```, which should be extended further by adding network Gateway IP address. To see if debug toolbar appears or you can see development feature of symfony, please navigate to the following via your browser: ```http://localhots/app_dev.php```.

### Docker Cheat-sheet
I have listed few commands you might find useful if you don't have much experience working with Docker below.

```terminal
$ docker-compose up -d
```
_Adding flag ```-d``` will make ```docker-compose``` to run containers in the background_

```terminal
$ docker-compose logs
```
_It will displays logs in case containers running on detach mode_

```terminal
$ docker-compose ps
```
_It will display the status of running containers_

```terminal
$ docker-compose down
```
_It should be used to terminate the process of containers_

```terminal
$ docker-compose build
```
_If an error occurs during build or pulling images, you can continue the process again with ```build``` command_

### Support and Help
This is the early version and further documentation or code changes will occur within 15 days of release. PHP will be upgraded to version 7.2 as soon as xdebug resolves the compatibility and sodium library will also be added for the next release early January 2018.
>_**Disclaimer:** Please don't use this to deploy in production, this project been built for Symfony enthusiasts to attract more contributors and prospect companies whom wish to give an enterprise level PHP Framework a quick try, without a worry of configuration and installation of all required packages_