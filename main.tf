provider "tfe" {}

data "tfe_outputs" "admin" {
  organization = "demo-azadal-org"
  workspace    = "vault-aws-se-dyncreds"
}

data "vault_aws_access_credentials" "creds" {
  backend = data.tfe_outputs.admin.values.backend
  role    = data.tfe_outputs.admin.values.role
}

provider "vault" {
  address            = "http://${var.vault_address}"
  add_address_to_env = true
  token              = var.vault_token
}

provider "aws" {
  region     = var.region
  access_key = data.vault_aws_access_credentials.creds.access_key
  secret_key = data.vault_aws_access_credentials.creds.secret_key
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Create AWS EC2 Instance
resource "aws_instance" "main" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.nano"

  tags = {
    Name  = var.name
    TTL   = var.ttl
    owner = "${var.name}-guide"
  }
}
