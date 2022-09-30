#!/bin/bash

# INSTALL GIT
sudo yum install git -y
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
# DEPLOY OUR DATABASE INSIDE THE MYSQL CONTAINER
# RUN MY CONTAINER - FLASK APP RUNNING