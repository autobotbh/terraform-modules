resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
   subnet_id     = var.public_subnet_id
   associate_public_ip_address = true
   availability_zone = "ap-south-1a"
   vpc_security_group_ids = [var.security_grp]

  tags = {
    Name = "docker"
  }
}