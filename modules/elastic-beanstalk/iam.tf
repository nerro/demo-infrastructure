resource "aws_iam_role" "ec2-role" {
  name = "${var.application_name}-${var.application_environment}-ec2-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
resource "aws_iam_instance_profile" "ec2-role" {
  name = "${var.application_name}-${var.application_environment}-ec2-role"
  role = "${aws_iam_role.ec2-role.name}"
}

resource "aws_iam_role" "elasticbeanstalk-service-role" {
  name = "${var.application_name}-${var.application_environment}-elasticbeanstalk-service-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "elasticbeanstalk.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "web-tier" {
  name = "web-tier"
  roles = [
    "${aws_iam_role.ec2-role.name}"
  ]
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}
resource "aws_iam_policy_attachment" "worker-tier" {
  name = "worker-tier"
  roles = [
    "${aws_iam_role.ec2-role.name}"
  ]
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWorkerTier"
}
resource "aws_iam_policy_attachment" "docker" {
  name = "docker"
  roles = [
    "${aws_iam_role.ec2-role.name}"
  ]
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkMulticontainerDocker"
}

resource "aws_iam_policy_attachment" "health" {
  name = "health"
  roles = [
    "${aws_iam_role.elasticbeanstalk-service-role.name}"
  ]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkEnhancedHealth"
}
resource "aws_iam_policy_attachment" "beanstalk" {
  name = "beanstalk"
  roles = [
    "${aws_iam_role.elasticbeanstalk-service-role.name}"
  ]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkService"
}
resource "aws_iam_policy_attachment" "ecr-read" {
  name = "ecr-read"
  roles = [
    "${aws_iam_role.elasticbeanstalk-service-role.name}"
  ]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}
