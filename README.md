# Guide for Using outline-terraform-aws

This project aims to deploy the Outline Wiki on AWS using Terraform and Ansible. Ensure that you have basic knowledge of AWS and Terraform before proceeding with the steps below.

## Setup

### Pre-requisite Software Installation

1. Ensure that [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) and [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) are installed on your system.
   
   ```bash
   # Example command to install Terraform
   sudo apt-get install terraform

   # Example command to install Ansible
   sudo apt-get install ansible
   ```
   
### Creating the `secret.tf` File

2. Refer to `secret.tf.demo` to create your `secret.tf`.
   - `secret.tf` will hold secret variables related to your AWS account.

## Build

### Running Terraform

3. Use the following commands to initialize and apply your Terraform configuration.

   ```bash
   terraform init
   terraform apply
   ```
   
4. After Terraform executes successfully, point your `DOMAIN` DNS record to the created EIP.
   - For instance, if the EIP is `1.2.3.4`, set your `example.com` A record to `1.2.3.4`.

## AWS S3 Permissions Setup

5. Ensure that your S3 Bucket has the correct permissions set. For detailed setup steps, refer [here](https://docs.getoutline.com/s/125de1cc-9ff6-424b-8415-0d58c809a40f#h-permissions).

## References

- [Outline Github Repository](https://github.com/outline/outline)
- [Vinelab Ansible Redis](https://github.com/Vinelab/ansible-redis/tree/master)
- [Outline-Terraform-Ansible project by rjsgn](https://github.com/rjsgn/outline-terraform-ansible)