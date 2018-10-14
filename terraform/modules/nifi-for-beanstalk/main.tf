resource "aws_elastic_beanstalk_application" "tftest" {
  name        = "tf-test-name"
  description = "tf-test-desc"
}

resource "aws_elastic_beanstalk_application_version" "default" {
  name        = "tf-test-version-label"
  application = "${aws_elastic_beanstalk_application.tftest.name}"
  bucket      = "z0beat-nifi-packages"
  key         = "package.zip"
}

resource "aws_elastic_beanstalk_configuration_template" "tf_template" {
  name                = "tf-test-template-config"
  application         = "${aws_elastic_beanstalk_application.tftest.name}"
  solution_stack_name = "64bit Amazon Linux 2018.03 v2.12.3 running Docker 18.06.1-ce"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "InstanceType"
    value = "t3.medium"
  }
}

resource "aws_elastic_beanstalk_environment" "tfenvtest" {
  name                = "tf-test-name"
  application         = "${aws_elastic_beanstalk_application.tftest.name}"
  template_name       = "${aws_elastic_beanstalk_configuration_template.tf_template.name}"
  version_label       = "${aws_elastic_beanstalk_application_version.default.name}"
}