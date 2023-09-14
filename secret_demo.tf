module "secret" {
  source = "./module"
  # AWS
  aws_region  = ""
  aws_profile = ""
  aws_account = ""
  # EC2
  instance_type    = ""
  aws_ami          = "" # Amazon Linux 2
  user             = ""
  private_key      = ""
  private_key_file = ""
  # RDS
  db_password = ""
  db_username = ""
  db_name     = ""
  # AKSK
  aws_access_key_id     = ""
  aws_access_key_secret = ""
  # Slack
  slack_secret = ""
  slack_key    = ""
  # Google
  google_client_id = ""
  google_client_secret = ""
  # Domain
  domain_name = ""
  admin_email = ""
}
