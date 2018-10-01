#!/bin/bash
clear
output=`uname -a`
compose_file='docker-compose.yml'
if [[ output = *"darwin"* ]]; then
    compose_file='docker-compose.mac.yml'
fi
build() {
    existingImage=`docker image ls | grep docfony`
    if [ -z "$existingImage" ]; then
        docker-compose -f docker/$compose_file build
        rm docker/httpd/symfony.conf
        rm docker/nginx/default.conf
    fi
    docker-compose -f docker/$compose_file up -d --remove-orphans
    docker-compose -f docker/$compose_file exec php bash
}
opt1() {
    cp docker/httpd/v3/symfony.conf docker/httpd/
    cp docker/nginx/v3/default.conf docker/nginx/
    build
}
opt2() {
    cp docker/httpd/v4/symfony.conf docker/httpd/
    cp docker/nginx/v4/default.conf docker/nginx/
    build
}
quit() {
    docker-compose -f docker/$compose_file stop
    docker-compose -f docker/$compose_file down -v --remove-orphans
}
PS3='Please enter your choice: '
options=("Symfony 3" "Symfony 4" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Symfony 3")
	    echo "Setting up the docker for Symfony 3"
        echo "Preparing NGINX and Apache httpd"
	    opt1
        break
        ;;
        "Symfony 4")
        echo "Setting up the docker for Symfony 4"
        echo "Preparing NGINX and Apache httpd"
	    opt2
        break
        ;;
        "Quit")
        quit
        break
        ;;
        *) echo invalid option;;
    esac
done