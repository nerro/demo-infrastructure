resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = "true"
  enable_dns_support = "true"

  tags {
    Name = "${var.application_name}-${var.application_environment}"
  }
}

resource "aws_subnet" "public" {
  vpc_id = "${aws_vpc.this.id}"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "${var.availability_zone}"

  tags {
    Name = "public_${var.application_name}-${var.application_environment}"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = "${aws_vpc.this.id}"

  tags {
    Name = "${var.application_name}-${var.application_environment}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.this.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.this.id}"
  }
}

resource "aws_route_table_association" "public" {
  route_table_id = "${aws_route_table.public.id}"
  subnet_id = "${aws_subnet.public.id}"
}

resource "aws_security_group" "http" {
  vpc_id = "${aws_vpc.this.id}"
  name = "HTTP - ${var.application_name}-${var.application_environment}"
  description = "Allow HTTP traffic to application - ${var.application_name}"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}