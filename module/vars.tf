variable "aws_region" {
  description = "AWS Region"
}

variable "aws_profile" {
  description = "AWS Profile"
}

variable "aws_account" {
  description = "AWS Account"
}

variable "instance_type" {
  description = "instance_type"
}

variable "aws_ami" {
  description = "AWS AMI"
}

variable "user" {
  type        = string
  description = "Username for the SSH Key"
}

variable "private_key" {
  type        = string
  description = "SSH private key"
}

variable "private_key_file" {
  type        = string
  description = "SSH private key"
}

### Database Setting

variable "db_password" {
  type        = string
  description = "database password"
}

variable "db_username" {
  type        = string
  description = "database user"
}

variable "db_name" {
  type        = string
  description = "database name"
}

### S3 Setting

variable "s3_name" {
  type = string
  description = "s3_name"
}

variable "aws_access_key_id" {
  type        = string
  description = "aws_access_key_id"
}

variable "aws_access_key_secret" {
  type        = string
  description = "aws_access_key_secret"
}

### Slack Setting

variable "slack_secret" {
  type        = string
  description = "slack_secret"
}

variable "slack_key" {
  type        = string
  description = "slack_key"
}
variable "google_client_id" {
  type        = string
  description = "google_client_id"
}

variable "google_client_secret" {
  type        = string
  description = "google_client_secret"
}

variable "google_allowed_domains" {
  type = string
  description = "google_allowed_domains"
}

variable "public_url" {
  type = string
  description = "public_url"
}

variable "force_https" {
  type = string
  description = "force_https"
}

variable "utils_secret" {
  type = string
  description = "utils_secret"
}

variable "secret_key" {
  type = string
  description = "secret_key"
}

variable "slack_app_id" {
  type = string
  description = "slack_app_id"
}
variable "slack_verification_token" {
  type = string
  description = "slack_verification_token"
}

variable "sentry_dsn" {
  type = string
  description = "sentry_dsn"  
}