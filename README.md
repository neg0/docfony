# Docfony - Docker Symfony 4 and 3
<p><img src="https://travis-ci.org/impixel/docfony.svg?branch=master" alt="build:passed"></p>

* **PHP** _version 7.2_
* **NGINX** _version 1.15_
* **Apache (httpd)** _version 2.4_
* **MySQL** _version 8.0_
* **Mongo** _version 4.0_

## Requirements 
* Operating Systems supported by Docker _<small>(Please checkout <a href="https://docs.docker.com/engine/installation/#supported-platforms" target="_blank">Supported platforms</a>)</small>_
* Docker version 17.x _<small>(Please visit <a href="https://www.docker.com/community-edition" target="_blank">Docker Community Edition</a>)</small>_
* Docker Compose  should be enabled
* Symfony Framework 4 and 3

### Download
Please ensure there is no similar service are running on the same ports on your host machine before start running the containers; after successfully cloning the repository, you should see a folder named **docfony**; please go inside the **docfony** and run `docker-compose` as below:
```bash
$ git clone https://github.com/impixel/docfony.git
$ cd docfony
```

Docker daemon starts to download and build the required images to run your Symfony application. During process docker will create three virtual volumes for data presistency for both databases MySQL and Mongo:
* __docfony-dev-mysql__ _It will store MySQL Database data files from_ `/var/lib/mysql` 
* __docfony-dev-mongo__ _It will store Mongo Database data files from_ `/data/db`
* __docfony-dev-mongo-config__ _It will store Mongo Database config data from_ `/data/configdb`

However for development purpose volume for Symfony application is shared with your machine (Host) and is accessible via folder outside of **docfony**, called **project**.

>In addition to virtual volumes, Docker will also creates a **network** with **bridge** driver named `docfony_symfony_dev` to make the containers to communicate with each other

### Installation via Composer
Please execute the Docker shell at the root of Docfony as presented below:
```bash
$ ./docker.sh
```
It will display three options to choose from: 
1) Symfony 3 
2) Symfony 4 
3) Quit

After successfully pulling and building the images required, you can see the log messages appearing on your terminal, and docker shell will automatically enters to PHP container bash shell, now you can install your symfony application.

**Symfony 4**
```bash
root@2ecca:/var/www#: composer create-project symfony/website-skeleton symfony_app
```

**Symfony 3**
```bash
root@2ecca:/var/www#: composer create-project symfony/framework-standard-edition symfony_app
```

### Quit and remove the containers
In order to quit from container please exit the container and run the docker shell and choose the third option (Quit), as demonstrated below:
```bash
root@2ecca:/var/www#: exit
$ ./docker.sh
```

>**Please Note** Project name must be `symfony_app` as illustrated above due to NGINX and Apache (httpd) path configuration.

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
You may use GUI applications to manage your database by specifying `mysql` or `mongo` as a host and specified port in `docker-compose.yml`. Please use following to connect to MySQL, Mongo Database and Xdebug via your machine:

* __MySQL Database__
    * Host: _mysql_
    * Port: _3308_
* __Mongo Database__
    * Host: _mongo_
    * Port: _27017_
* __Xdebug__
    * Port: _9001_

> **Please Note** you may also use IP address `127.0.0.1` as a host for each service instead.

### Local Development
You can view and edit your codes via `project` folder outside of `docfony` and change on your machine will be synchronised with running containers.
>**Please Note** make sure your containers are running while you are making changes to your project to ensure data persistency all across containers with the host machine 

### Re-Activate Symfony 3 Debug Feature
Now you may navigate to `project/symfony_app/web/app_dev.php` and `project/symfony_app/web/config.php` you should see an array of `['127.0.0.1', '::1']`, which should be extended further by adding network Gateway IP address `172.25.0.2`. To see if debug toolbar appears or you can see development feature of symfony, please navigate to the following via your browser: `http://localhots/app_dev.php`.
In order to find your Gateway IP address _(This IP address should be: 172.25.0.2 as specified in the compose file)_, please run the following:
```bash
$ docker network inspect docfony_symfony_dev --format="{{json .IPAM.Config}}"
```
```json
[{"Subnet":"172.25.0.0/16","Gateway":"172.25.0.2"}]
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

### Support and Help
If you found an issue, please use git issues to report and if you wish to contribute to this project feel free to fork and create a pull request to the develop branch
>_**Disclaimer:** Please don't use this to deploy in production, this project been built for Symfony enthusiasts to attract more contributors and prospect companies whom wish to give an enterprise level PHP Framework a quick try, without a worry of configuration and installation of all required packages_

### License
Regarding licensing and version of please visit: [Creative Commons License](https://creativecommons.org/licenses/by-sa/4.0/) or read through license file `LICENSE.md` included in the repository.

![CC Attribution-ShareAlike](https://licensebuttons.net/l/by-sa/3.0/88x31.png)