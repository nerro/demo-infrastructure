data "aws_caller_identity" "current" {}
resource "aws_s3_bucket" "configuration" {
  bucket = "${data.aws_caller_identity.current.account_id}-${var.application_name}-${var.application_environment}-configuration"
}
resource "aws_s3_bucket_object" "initial-deployment" {
  bucket = "${aws_s3_bucket.configuration.bucket}"
  key = "docker-multicontainer-v2.zip"
  source = "${path.module}/docker-multicontainer-v2.zip"
}
resource "aws_elastic_beanstalk_application_version" "this" {
  name = "${aws_elastic_beanstalk_application.this.name}-initial-version"
  application = "${aws_elastic_beanstalk_application.this.name}"
  bucket = "${aws_s3_bucket.configuration.id}"
  key = "${aws_s3_bucket_object.initial-deployment.id}"
}

resource "aws_elastic_beanstalk_application" "this" {
  name = "${var.application_name}"
  description = "${var.application_description}"
}
//resource "aws_elastic_beanstalk_environment" "this" {
//  name = "${var.application_name}-${var.application_environment}"
//  application = "${aws_elastic_beanstalk_application.this.name}"
//  solution_stack_name = "64bit Amazon Linux 2017.09 v2.9.1 running Multi-container Docker 17.12.0-ce (Generic)"
//  cname_prefix = "${var.application_name}-${var.application_environment}"
//  version_label = "${aws_elastic_beanstalk_application_version.this.name}"
//  wait_for_ready_timeout = "5m"
//
//  # required settings
//  setting {
//    namespace = "aws:ec2:vpc"
//    name = "VPCId"
//    value = "${aws_vpc.this.id}"
//  }
//  setting {
//    namespace = "aws:ec2:vpc"
//    name = "Subnets"
//    value = "${aws_subnet.public.id}"
//  }
//  setting {
//    namespace = "aws:autoscaling:launchconfiguration"
//    name = "IamInstanceProfile"
//    value = "${aws_iam_instance_profile.ec2-role.name}"
//  }
//  setting {
//    namespace = "aws:elasticbeanstalk:environment"
//    name = "ServiceRole"
//    value = "${aws_iam_role.elasticbeanstalk-service-role.name}"
//  }
//
//  # ASG settings
//  setting {
//    namespace = "aws:ec2:vpc"
//    name = "AssociatePublicIpAddress"
//    value = "false"
//  }
//  setting {
//    namespace = "aws:autoscaling:launchconfiguration"
//    name = "SecurityGroups"
//    value = "${aws_security_group.http.id}"
//  }
//  setting {
//    namespace = "aws:autoscaling:launchconfiguration"
//    name = "InstanceType"
//    value = "t2.micro"
//  }
//  setting {
//    name = "MinSize"
//    namespace = "aws:autoscaling:asg"
//    value = "1"
//  }
//  setting {
//    name = "MaxSize"
//    namespace = "aws:autoscaling:asg"
//    value = "1"
//  }
//
//  # ELB settings
//  setting {
//    namespace = "aws:ec2:vpc"
//    name = "ELBSubnets"
//    value = "${aws_subnet.public.id}"
//  }
//  setting {
//    namespace = "aws:ec2:vpc"
//    name = "ELBScheme"
//    value = "public"
//  }
//
//  # other settings
//  setting {
//    namespace = "aws:elasticbeanstalk:healthreporting:system"
//    name = "SystemType"
//    value = "enhanced"
//  }
//  setting {
//    namespace = "aws:elasticbeanstalk:command"
//    name = "BatchSizeType"
//    value = "Fixed"
//  }
//  setting {
//    namespace = "aws:elasticbeanstalk:command"
//    name = "BatchSize"
//    value = "1"
//  }
//  setting {
//    namespace = "aws:elasticbeanstalk:command"
//    name = "DeploymentPolicy"
//    value = "Rolling"
//  }
}
