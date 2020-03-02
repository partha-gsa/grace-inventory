//terraform {
//  backend "s3" {
//    region = "us-east-1"
//  }
//}
//
//provider "aws" {
//}
//
//// If the Lambda function is installed in a non-master/mgmt account, it can
//// list all accounts and inventory each one using the OrganizationAccessRole
//// if accounts_info = "" and master_account_id and master_role_name are set
//// and the roles are assumable by the Lambda function's IAM role
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "aws" {
  region = "us-east-1"
  endpoints {
    sns = "http://localhost:5000"
    cloudwatchlogs = "http://localhost:5000"
    cloudwatchevents = "http://localhost:5000"
    sts = "http://localhost:5000"
  }
}

resource "aws_cloudwatch_log_group" "integration_test" {
  name = "integration_test"
}

//module "integration_test" {
//  source = "../../../"
//  recipient = "a@b.c"
//  cloudtrail_log_group_name = aws_cloudwatch_log_group.integration_test.name
//}

module "integration_test" {
  source = "../../../"
  accounts_info     = "self"
  project_name      = "grace"
  appenv            = "integration-test"
  master_account_id = "123456789012"
  master_role_name  = "role"
  tenant_role_name  = "tenant-role"
  source_file       = "../release/grace-inventory-lambda.zip"
}
