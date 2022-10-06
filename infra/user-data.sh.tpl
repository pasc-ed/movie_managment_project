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

# BUILD MY DOCKER IMAGE FOR THE APPLICATION- DOCKERFILE
cd ~/movie_managment_project/app
docker build -t movie-mgmt .

# DEPLOY OUR DATABASE INSIDE THE RDS DATABASE
mysql -h ${db_endpoint} -u root -p${db_password} < ~/movie_managment_project/database/create_movie_database.sql

sed -i "s/ENDPOINT_PLACEHOLDER/${db_endpoint}/g" ~/movie_managment_project/app/movie_app/main.py
sed -i "s/PASSWORD_PLACEHOLDER/${db_endpoint}/g" ~/movie_managment_project/app/movie_app/main.py

# RUN MY CONTAINER - FLASK APP RUNNING
docker run -d -p 80:80 --name=movie-mgmt -v ~/movie_managment_project/app/movie_app:/app movie-mgmt