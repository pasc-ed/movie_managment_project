#!/bin/bash

# INSTALL GIT
sudo yum install git -y
# INSTALL DOCKER
sudo amazon-linux-extras install docker -y

# START DOCKER SERVICE
sudo service docker start
sudo usermod -a -G docker ec2-user

# CLONE MY MOVIE-MANGEMENT-PROJECT REPO
# BUILD MY DOCKER IMAGE - DOCKERFILE
# RUN MYSQL CONTAINER
# DEPLOY OUR DATABASE INSIDE THE MYSQL CONTAINER
# RUN MY CONTAINER - FLASK APP RUNNING