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

module "integration_test" {
  source = "../../../"
  accounts_info     = "self"
  project_name      = "grace"
  appenv            = "integration-test"
  master_account_id = "123456789012"
  master_role_name  = "role"
  tenant_role_name  = "tenant-role"
  source_file       = var.source_file
}
