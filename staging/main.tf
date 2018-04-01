terraform {
  backend "local" {
    path = ".terraform/terraform.state"
  }
}

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "${var.region}"
}

module "demo_staging" {
  source = "../modules/elastic-beanstalk"

  application_name = "${var.application_name}"
  application_environment = "${var.application_environment}"
  application_description = "${var.application_description}"

  availability_zone = "${var.availability_zone}"
}
