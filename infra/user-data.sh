#!/bin/bash

# INSTALL GIT AND MYSQL
apt-get install git mysql-client -y
# INSTALL DOCKER
apt-get install ca-certificates curl gnupg lsb-release
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
apt-get update
apt-get install docker.io -y

# CLONE MY MOVIE-MANGEMENT-PROJECT REPO
git clone --branch demo https://github.com/pasc-ed/movie_managment_project.git

# BUILD MY DOCKER IMAGE - DOCKERFILE
cd movie_managment_project/app
docker build -t movie-mgmt .

# RUN MYSQL CONTAINER
mkdir ~/database
docker run --name movie-db-mysql -p 3306:3306 -v ~/database:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:latest --default-authentication-plugin=mysql_native_password

# DEPLOY OUR DATABASE INSIDE THE MYSQL CONTAINER
mysql -h 127.0.0.1 -u -pmy-secret-pw < ../database/create_movie_database.sql

# RUN MY CONTAINER - FLASK APP RUNNING
docker run -d -p 80:80 --name=movie-mgmt -v $PWD/movie_app:/app movie-mgmt