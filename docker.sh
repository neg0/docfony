#!/bin/bash
clear
output=`uname -a`
compose_file='docker-compose.yml'
if [[ output = *"darwin"* ]]; then
    compose_file='docker-compose.mac.yml'
fi
opt1() {
	echo "Preparing NGINX and Apache httpd for Symfony 3"
    cp docker/httpd/v3/symfony.conf docker/httpd/
    cp docker/nginx/v3/default.conf docker/nginx/
    docker-compose -f docker/$compose_file up --build -d --remove-orphans
    docker-compose -f docker/$compose_file exec php bash
}
opt2() {
	echo "Preparing NGNIX and Apache httpd for Symfony 4"
    cp docker/httpd/v4/symfony.conf docker/httpd/
    cp docker/nginx/v4/default.conf docker/nginx/
    docker-compose -f docker/$compose_file up --build -d --remove-orphans
    docker-compose -f docker/$compose_file exec php bash
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
	    opt1
        break
        ;;
        "Symfony 4")
        echo "Setting up the docker for Symfony 4"
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