variable "name" { default = "dynamic-aws-creds-operator" }
variable "region" { default = "ap-south-1" }
variable "ttl" { default = "1" }

variable "vault_address" {
  default = "127.0.0.1:8200"
}

variable "vault_token" {
  default = ""
}
