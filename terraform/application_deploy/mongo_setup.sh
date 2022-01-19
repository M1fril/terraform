#!/bin/bash
    echo "Begin setup"    
    wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
    sudo apt update
    sudo apt -y install mongodb-org
    sudo systemctl start mongod
    sudo systemctl enable mongod
    echo "End setup" 
    systemctl is-enabled mongod