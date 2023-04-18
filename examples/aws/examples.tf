provider "aws" {
  region  = "eu-west-1"  
  
}

terraform {
  #required_version = "~> 1.0.0"

  required_providers {
    aws    = ">= 3.53.0"
   # local  = ">= 2.1"
   # random = ">= 3.1"
  }
}


module "api_gateway" {
  source       = "./api_gateway"
  project_name = local.project_name
  tags         = local.tags
}

module "config_custom_rule" {
  source       = "./config_custom_rule"
  project_name = local.project_name
  tags         = local.tags
}

module "ecs_fargate_task" {
  source       = "./ecs_fargate_task"
  project_name = local.project_name
  tags         = local.tags
}

module "lambda_function" {
  source       = "./lambda_function"
  project_name = local.project_name
  tags         = local.tags
}

module "lambda_function_event_rule" {
  source       = "./lambda_function_event_rule"
  project_name = local.project_name
  tags         = local.tags
}

module "lambda_function_sns" {
  source       = "./lambda_function_sns"
  project_name = local.project_name
  tags         = local.tags
}

module "lambda_function_sqs" {
  source       = "./lambda_function_sqs"
  project_name = local.project_name
  tags         = local.tags
}

module "sfn_state_machine" {
  source       = "./sfn_state_machine"
  project_name = local.project_name
  tags         = local.tags
}
