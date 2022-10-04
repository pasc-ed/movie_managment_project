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
git clone --branch demo2 https://github.com/pasc-ed/movie_managment_project.git

# BUILD MY DOCKER IMAGE - DOCKERFILE
cd movie_managment_project/app
docker build -t movie-mgmt .

# RUN MYSQL CONTAINER
mkdir ~/database
docker run --name movie-db-mysql -p 3306:3306 -v ~/database:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:latest --default-authentication-plugin=mysql_native_password

# DEPLOY OUR DATABASE INSIDE THE MYSQL CONTAINER
# RUN MY CONTAINER - FLASK APP RUNNING
docker run -d -p 80:80 --name=movie-mgmt -v $PWD/movie_app:/app movie-mgmt