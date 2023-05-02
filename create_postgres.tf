resource "aws_db_instance" "outline-postgres" {
  allocated_storage    = 10
  db_name              = "outlinedb"
  engine               = "postgres"
  engine_version       = "13.4"
  instance_class       = "db.t3.micro"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.postgres13"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.outline-db-subnet-group.id
  vpc_security_group_ids = [aws_security_group.outline-sg.id]
  tags = {
    Name = "outline-postgres"
  }
}

resource "aws_db_subnet_group" "outline-db-subnet-group" {
  name       = "outline-db-subnet-group"
  subnet_ids = [aws_subnet.outline-subnet-private.id,aws_subnet.outline-subnet-private2.id]
}
