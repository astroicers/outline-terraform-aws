provider "aws" {
  region = var.aws_region
  profile = var.aws_profile
  version = "~> 5.10.0"
}

resource "aws_vpc" "outline-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "outline-vpc"
  }
}

resource "aws_subnet" "outline-subnet" {
  vpc_id                  = aws_vpc.outline-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "outline-subnet"
  }
}

resource "aws_subnet" "outline-subnet-private" {
  vpc_id                  = aws_vpc.outline-vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "${var.aws_region}a"

  tags = {
    Name = "outline-subnet-private"
  }
}

resource "aws_subnet" "outline-subnet-private2" {
  vpc_id                  = aws_vpc.outline-vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "${var.aws_region}b"

  tags = {
    Name = "outline-subnet-private2"
  }
}

resource "aws_route_table_association" "outline-rta" {
  subnet_id      = aws_subnet.outline-subnet.id
  route_table_id = aws_route_table.outline-rt.id
}

resource "aws_route_table" "outline-rt" {
  vpc_id = aws_vpc.outline-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.outline-igw.id
  }
  tags = {
    Name = "outline-rt"
  }
}
resource "aws_internet_gateway" "outline-igw" {
  vpc_id = aws_vpc.outline-vpc.id

  tags = {
    Name = "outline-igw"
  }
}

resource "aws_security_group" "outline-sg" {
  name   = "sg"
  vpc_id = aws_vpc.outline-vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    source_security_group_id  = aws_security_group.outline-sg.id
  }
  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    source_security_group_id  = aws_security_group.outline-sg.id
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "outline-sg"
  }
}

