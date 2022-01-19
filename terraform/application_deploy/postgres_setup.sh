#!/bin/bash
    echo "Begin setup"  
    sudo apt update
    sudo apt -y upgrade
    sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
    sudo apt-get update
    sudo apt install -y postgresql-13 postgresql-client-13
    echo "End setup" 
    systemctl is-enabled postgresql
    sudo su - postgres
    
   