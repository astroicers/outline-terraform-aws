provider "aws" {
  region = "us-west-2"
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
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "outline-subnet"
  }
}

resource "aws_subnet" "outline-subnet-private" {
  vpc_id                  = aws_vpc.outline-vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-west-2a"

  tags = {
    Name = "outline-subnet-private"
  }
}

resource "aws_subnet" "outline-subnet-private2" {
  vpc_id                  = aws_vpc.outline-vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-west-2b"

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
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 6789
    to_port     = 6789
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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

resource "aws_instance" "outline-ec2" {
  ami                    = "ami-0747e613a2a1ff483"
  instance_type          = "t2.micro"
  key_name               = "demo-key-us-west-2"
  subnet_id              = aws_subnet.outline-subnet.id
  vpc_security_group_ids = [aws_security_group.outline-sg.id]
  tags = {
    Name = "outline-ec2"
  }
}

resource "aws_instance" "outline-ec2-private" {
  ami                    = "ami-0747e613a2a1ff483"
  instance_type          = "t2.micro"
  key_name               = "demo-key-us-west-2"
  subnet_id              = aws_subnet.outline-subnet-private.id
  vpc_security_group_ids = [aws_security_group.outline-sg.id]
  tags = {
    Name = "outline-ec2-private"
  }
}
