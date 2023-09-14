resource "aws_elasticache_cluster" "outline-redis" {
  cluster_id               = "outline-redis"
  engine                   = "redis"
  node_type                = "cache.t2.micro"
  num_cache_nodes          = 1
  subnet_group_name        = aws_elasticache_subnet_group.outline-redis-subnet-group.id
  port                     = 6379
  parameter_group_name     = "default.redis7"
  security_group_ids       = [aws_security_group.outline-sg.id]

  tags = {
    Name = "outline-redis"
  }
}

resource "aws_elasticache_subnet_group" "outline-redis-subnet-group" {
  name       = "outlineredissubnetgroup"
  subnet_ids = [aws_subnet.outline-subnet-private.id,aws_subnet.outline-subnet-private2.id]
}
