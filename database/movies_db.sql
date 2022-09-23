# Create a new database
CREATE DATABASE movie_db;

# Show all databases
SHOW DATABASES;

# Use our new database
USE movie_db;

# Show existing tables
SHOW TABLES;

# Create table directors
CREATE TABLE directors_tbl(
    id int NOT NULL AUTO_INCREMENT,
    name varchar(255),
    year_of_birth int,
    PRIMARY KEY (id)
);

# Get information about the table
# DESCRIBE <Table_name>
DESCRIBE directors_tbl;

# Add a new entry to the table
INSERT INTO directors_tbl VALUES(
    null,
    "James Cameron",
    1954
);

# Show all data from table
# SELECT
# FROM
# <WHERE>
SELECT * FROM directors_tbl;

# Create our Movie table
CREATE TABLE movies_tbl(
    id int NOT NULL AUTO_INCREMENT,
    title varchar(255),
    release_year int,
    director_id int NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (director_id) REFERENCES directors_tbl(id)
);