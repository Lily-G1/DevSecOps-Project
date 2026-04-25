#!/bin/bash
sudo apt update

# install docker
sudo apt install docker.io -y

# give ubuntu user elevated permissions for docker
sudo usermod -aG docker ubuntu
sudo newgrp docker 

# run sonarqube container
docker run -d --name sonar -p 9000:9000 sonarqube:latest
