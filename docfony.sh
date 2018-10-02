#!/bin/bash
clear
output=`uname -a`
compose_file='docker-compose.yml'
if [[ output = *"darwin"* ]]; then
    compose_file='docker-compose.mac.yml'
fi
PS3='Please enter the container you wish to enter: '
options=("PHP" "NGNIX" "Apache (httpd)" "MySQL" "Mongo" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "PHP")
        docker-compose -f docker/$compose_file exec php bash
        ;;
        "NGNIX")
        docker-compose -f docker/$compose_file exec nginx bash
        ;;
        "Apache (httpd)")
        docker-compose -f docker/$compose_file exec httpd bash
        ;;
        "MySQL")
        docker-compose -f docker/$compose_file exec mysql bash
        ;;
        "Mongo")
        docker-compose -f docker/$compose_file exec mongo bash
        ;;
        "Quit")
        echo "Thank you for using Docfony"
        break
        ;;
        *) echo invalid option;;
    esac
done