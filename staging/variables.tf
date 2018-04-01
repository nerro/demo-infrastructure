variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "us-east-1"
}
variable "availability_zone" {
  default = "eu-east-1a"
}

variable "application_name" {
  default = "demo"
}
variable "application_description" {}
variable "application_environment" {
  default = "staging"
}
