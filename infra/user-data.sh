#!/bin/bash

# INSTALL GIT AND MYSQL
sudo yum install git mysql -y
# INSTALL DOCKER
sudo amazon-linux-extras install docker -y

# START DOCKER SERVICE
sudo service docker start
sudo usermod -a -G docker ec2-user

# CLONE MY MOVIE-MANGEMENT-PROJECT REPO
git clone --branch demo https://github.com/pasc-ed/movie_managment_project.git

# BUILD MY DOCKER IMAGE - DOCKERFILE
cd movie_managment_project/app
docker build -t movie-mgmt .

# RUN MYSQL CONTAINER
mkdir ~/database
docker run --name movie-db-mysql -p 3306:3306 -v ~/database:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:latest --default-authentication-plugin=mysql_native_password

# DEPLOY OUR DATABASE INSIDE THE MYSQL CONTAINER
# RUN MY CONTAINER - FLASK APP RUNNING
docker run -d -p 80:80 --name=movie-mgmt -v $PWD/movie_app:/app movie-mgmt