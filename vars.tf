variable "private_key" {
  type        = string
  description = "Absolute path to the SSH private key. This private key will be used for SSH authentication."
  default     = "../cs-dev-team.key"
}