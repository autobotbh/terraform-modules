resource "aws_vpc" "my_vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"
  assign_generated_ipv6_cidr_block = true

  tags = {
    Name = "docker-test-server"
  }
}

resource "aws_subnet" "sn-public" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.cidr_public_sn

  tags = {
    Name = "public"
  }
}

resource "aws_subnet" "sn-private" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.cidr_private_sn

  tags = {
    Name = "private"
  }
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "internet_gateway"
  }
}

resource "aws_egress_only_internet_gateway" "egw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "egress_gateway"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    egress_only_gateway_id = aws_egress_only_internet_gateway.egw.id
  }

  tags = {
    Name = "routetable_public"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.sn-public.id
  route_table_id = aws_route_table.rt.id
}