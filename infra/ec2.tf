resource "aws_instance" "movie_app_server" {
  ami                    = data.aws_ami.amz_linux_image.id
  instance_type          = var.movie_app_ec2_type
  subnet_id              = data.aws_subnet.public_subnet_a.id
  vpc_security_group_ids = [aws_security_group.movie_app_sg.id]
  key_name = var.keypair_name
  user_data = "${path.module}/user-data.sh"

  tags = {
    Name = "movie-mgmt-server"
  }
}