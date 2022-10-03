#!/bin/bash

# INSTALL GIT AND POSTGRE
sudo yum install git postgresql  -y
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

# RUN POSTGRE CONTAINER
mkdir ~/database
docker run -d \
	--name postgres-movie-db \
	-e POSTGRES_PASSWORD=my-secret-pw \
	-e PGDATA=/var/lib/postgresql/data/pgdata \
	-v ~/database:/var/lib/postgresql/data \
    -p 5432:5432 \
	postgres

# DEPLOY OUR DATABASE INSIDE THE POSTGRE CONTAINER
mysql -h 127.0.0.1 -u root -pmy-secret-pw < ../database/create_movie_database.sql

# RUN MY CONTAINER - FLASK APP RUNNING
docker run -d -p 80:80 --name=movie-mgmt -v $PWD/movie_app:/app movie-mgmt