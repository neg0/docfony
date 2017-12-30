# Docfony - Docker Symfony 3.x
* PHP version 7.2
* NGINX version 1.3
* MySQL version 5.7
* Mongo version 1.2

## Requirements 
* Operating Systems supported by Docker _Please look at [Supported platforms](https://docs.docker.com/engine/installation/#supported-platforms)_
* Docker version v17.x _(Tested only)_
* Docker Compose  should be enabled

### Download and Installation
After successfully cloning the repository, you should see a folder named _docfony_; please go inside the _docfony_ and run __docke-compose__ as below:
```terminal
$ git clone http://
$ cd docfony
$ docker-compose up
```
Docker daemon should start download and build the required images to run your Symfony Application supported and tested only for v3.x. During process docker will create two virtual volumes for data presistency:
* __docfony-dev-mysql__ _It will store MySQL Database data files from_ ```/var/lib/mysql``` 
* __docfony-dev-mongo__ _It will store Mongo Database data files from_ ```/data```

However for development purpose volume for Symfony application itself is shared with your machine (Host) and is accessible via folder outside of ```docfony```, called ```project```.

>In addition to virtual volumes, Docker will also creates a **network** with **bridge** driver named ```docfony-symfony-dev``` to make the containers to communicate with each other

After successfully pulling and building the images required, you can see the log messages appearing on your terminal, please open a new terminal tab and connect to the **php** container to download and install your Symfony application as below:
```
$ docker-compose exec php /bin/bash
root@d38cf:/var/www# composer create-project symfony/framework-standard-edition symfony_app 3.4
```
Composer will download the necessary packages for your Symfony application and now you can view the app via your browser from following URL:
```http://localhost ```, you may also view your application via virtual host domain: ```http://docfony.dev```
>**Please Note:** you need to add ```docfony.dev``` assigned to ```127.0.0.1```  on your host machine (Mac/Linux in /etc/hosts and for Windows via Firewall settings)

### Symfony Parameters
Example of parameters being asked during Symfony installation below:
```
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
###Hosts and Ports
You may use GUI applications to manage your database by specifying ```mysql``` or ```mongo``` as a host and specified port in ```docker-compose.yml```, please use following to connect to MySQL and Mongo Database via your machine:

* __MySQL Database__
    * Host: _mysql_
    * Port: _3306_
* __Mongo Database__
    * Host: _mongo_
    * Port: _27017_
> **Please Note** you maye also use actual IP address of each container using ```docker network inspect```, but this require more knowledge about Docker Networking; However, we discuss inspection later on for enabling Symfony debug features
### Local Development
You can view and edit your codes via ```project``` folder outside of ```docfony``` and change on your machine will be synchronised with running containers.
>**Please Note** make sure your containers are running while you are making changes to your project to ensure data presistency all across containers with the host machine 

### Re-Activate Symfony Debug Feature
In order to find your Gateway IP address, please run the following:
```
$ docker network inspect docfony_symfony_dev --format="{{json .IPAM.Config}}"
[{"Subnet":"172.23.0.0/16","Gateway":"172.23.0.1"}]
```
Now you may navigate to ```project/symfony_app/web/app_dev.php``` and edit line 15, you should see an array of ```['127.0.0.1', '::1']```, which should be extended further by adding network Gateway IP address. To see if debug toolbar appears or you can see development feature of symfony, please navigate to the following via your browser: ```http://localhots/app_dev.php```

###Support and Help
This is the early version and further documentation or code changes will occur within 15 days of release.
>_**Disclaimer:** Please don't use this to deploy in production, this project been built for Symfony enthusiasts to attract more contributors and prospect companies whom wish to give an enterprise level PHP Framework a quick try, without a worry of configuration and installation of all required packages_