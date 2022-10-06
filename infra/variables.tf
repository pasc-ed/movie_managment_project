# DEFINE VARIABLES
variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "public_subnet_a_name" {
  description = "The name of my Public Subnet A"
  type        = string
}

variable "private_subnet_a_name" {
  description = "The name of my private Subnet A"
  type        = string
}

variable "private_subnet_b_name" {
  description = "The name of my private Subnet B"
  type        = string
}

variable "amzn_ami_name" {
  description = "The name of the ami"
  type        = string
}

variable "amzn_ami_owner" {
  description = "The owner id of the ami"
  type        = string
}

variable "movie_app_ec2_type" {
  description = "The type of the EC2 instance for movie app"
  type        = string
}

variable "keypair_name" {}

variable "db_storage" {
  description = "Size of the disk for the database"
}

variable "db_name" {
  description = "Name of the database"
}

variable "db_engine" {
  description = "The DB engine to run on our RDS"
}
variable "db_engine_version" {
  description = "The version of the db engine"
}

variable "db_instance_class" {
  description = "Instance type for the DB"
}

variable "db_username" {
  description = "Username to connect to the DB"
}

variable "db_skip_last_snapshot" {
  description = "Do not take a snapshot before destroying the DB"
  default     = true
}