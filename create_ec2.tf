resource "aws_instance" "outline-vm" {
  ami           = "ami-0fcf52bcf5db7b003"
  instance_type          = "t2.micro"
  key_name               = "demo-key-us-west-2"

  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = file(var.private_key)
    host = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update && sudo apt upgrade -y",
      "sudo apt install -y python3-pip",
      "pip3 install --upgrade pip",
      "pip3 install ansible"
    ]
  }

#   provisioner "local-exec" {
#     command = "ansible-playbook ../ansible/main.yml -i '${self.public_ip},' -e='${jsonencode({
#       ansible_python_interpreter = "/usr/bin/python3",
#       db_password = var.db_password,
#       db_username = var.db_user,
#       db_ip_address = aws_db_instance.outline_db_instance.address,
#       db_name = var.db_name,
#       server_ip = self.public_ip,
#       redis_host = var.enable_aws_redis ? aws_elasticache_cluster.outline_redis_cluster.cache_nodes.0.address : null,
#       redis_port = var.enable_aws_redis ? aws_elasticache_cluster.outline_redis_cluster.cache_nodes.0.port : null,
#       enable_redis = var.enable_aws_redis ? true : false
#     })}' -u=${var.user} --private-key=${var.private_key} --ssh-common-args='-o StrictHostKeyChecking=no'"
#   }
  tags = {
    "Name" = "outline-vm"
  }
}
