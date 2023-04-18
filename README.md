# Infra Terraform Modules

An **opinionated** set of **Terraform 0.12** compatible modules for standardized infrastructure provisioning.

## Repository Structure

The directories in this repository are organized in the following way:

- [**Examples**](examples): contains examples on how to use all available modules. These examples are also used to validate changes.
- [**Modules**]([**aws**](aws) and [**vsphere**](vsphere/virtual_machine)): contains all available modules and documentation on how to use each of them.

## Available Modules

### AWS

- [**api_gateway_cors**](aws/api_gateway_cors)
- [**api_gateway_custom_authorizer**](aws/api_gateway_custom_authorizer)
- [**api_gateway_method_to_lambda**](aws/api_gateway_method_to_lambda)
- [**api_gateway_rest_api**](aws/api_gateway_rest_api)
- [**config_custom_rule**](aws/config_custom_rule)
- [**ecr_repository**](aws/ecr_repository)
- [**ecs_fargate_task**](aws/ecs_fargate_task)
- [**iam_role_with_policy**](aws/iam_role_with_policy)
- [**lambda_function**](aws/lambda_function)
- [**lambda_function_event_rule**](aws/lambda_function_event_rule)
- [**lambda_function_sns**](aws/lambda_function_sns)
- [**lambda_function_sqs**](aws/lambda_function_sqs)
- [**sfn_state_machine**](aws/sfn_state_machine)

## Versions 0.2.x (deprecated)

From version `0.2.x` to `0.3.x`, the set of available modules was modified and breaking changes were introduced in the modules that remained.

