resource "local_file" "inventory_output" {
  filename = "${path.module}/../ansible/inventory.yml"
  content = templatefile("${path.module}/../ansible/inventory.tpl", {
    server_ip = aws_instance.outline-vm.public_ip,
    user      = var.user
  })
}

resource "aws_instance" "outline-vm" {
  ami                    = var.aws_ami
  instance_type          = var.instance_type
  key_name               = var.private_key
  subnet_id              = aws_subnet.outline-subnet.id
  vpc_security_group_ids = [aws_security_group.outline-sg.id]

  tags = {
    "Name" = "outline-vm"
  }
}

resource "aws_eip" "outline-eip" {
  instance = aws_instance.outline-vm.id
}

output "server_ip" {
  value = aws_eip.outline-eip.public_ip
}

locals {
  outline_env = {
    server_ip = aws_eip.outline-eip.public_ip

    db_ip_address = aws_db_instance.outline-postgres.address
    db_name       = var.db_name
    db_username   = var.db_username
    db_password   = var.db_password

    redis_host = aws_elasticache_cluster.outline-redis.cache_nodes.0.address
    redis_port = aws_elasticache_cluster.outline-redis.cache_nodes.0.port

    aws_region            = var.aws_region
    aws_access_key_id     = var.aws_access_key_id
    aws_access_key_secret = var.aws_access_key_secret

    aws_bucket_name   = aws_s3_bucket.outline-s3-bucket.bucket
    aws_s3_bucket_url = "https://${aws_s3_bucket.outline-s3-bucket.bucket}.s3.${var.aws_region}.amazonaws.com/"

    slack_secret = var.slack_secret
    slack_key    = var.slack_key
    slack_app_id = var.slack_app_id
    slack_verification_token = var.slack_verification_token

    google_client_id       = var.google_client_id
    google_client_secret   = var.google_client_secret
    google_allowed_domains = var.google_allowed_domains

    public_url  = var.public_url
    force_https = var.force_https

    sentry_dsn = var.sentry_dsn

    utils_secret = var.utils_secret
    secret_key   = var.secret_key
  }
}

resource "null_resource" "ansible_provisioner_server" {
  depends_on = [local_file.inventory_output, aws_instance.outline-vm]
  provisioner "local-exec" {
    command = "ansible-playbook ./ansible/main.yml -i ./ansible/inventory.yml --extra-vars='${jsonencode(local.outline_env)}' --ssh-common-args='-o StrictHostKeyChecking=no'"
  }
}
