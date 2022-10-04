#!/bin/bash

# INSTALL GIT AND MYSQL
sudo apt-get update
sudo apt-get install git mysql-client -y
# INSTALL DOCKER
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker.io -y

# CLONE MY MOVIE-MANGEMENT-PROJECT REPO
git clone --branch demo2 https://github.com/pasc-ed/movie_managment_project.git ~/movie_managment_project

# BUILD MY DOCKER IMAGE - DOCKERFILE
cd ~/movie_managment_project/app
docker build -t movie-mgmt .

# RUN MYSQL CONTAINER
mkdir ~/database
docker run --name movie-db-mysql -p 3306:3306 -v ~/database:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:latest

# wait 5 seconds for DB to come online
sleep 5

# DEPLOY OUR DATABASE INSIDE THE MYSQL CONTAINER
mysql -h 127.0.0.1 -u root -pmy-secret-pw < ~/movie_managment_project/database/create_movie_database.sql

container_ip=`docker inspect movie-db-mysql | grep -e '"IPAddress"' -m 1|awk -F '"' '{print $4}'`
sed -i "s/DOCKER_CONTAINER_IP_PLACEHOLDER/${container_ip}/g" ~/movie_managment_project/app/movie_app/main.py

# RUN MY CONTAINER - FLASK APP RUNNING
docker run -d -p 80:80 --name=movie-mgmt -v ~/movie_managment_project/app/movie_app:/app movie-mgmt