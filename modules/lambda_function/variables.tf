variable "region" {
  description = "AWS region where the resources are deployed"
  type        = string
}

variable "account_id" {
  description = "AWS account ID"
  type        = string
}

variable "project_name1" {
  description = "Name of the first CodeBuild project"
  type        = string
}

variable "project_name2" {
  description = "Name of the second CodeBuild project"
  type        = string
}

variable "bucket_name" {
  description = "Name of the S3 bucket used for logs or artifacts"
  type        = string
}

variable "function_name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "zip_file_path" {
  description = "Path to the Lambda deployment package zip file"
  type        = string
}

variable "inline_policy_path" {
  description = "Path to the inline IAM policy file"
  type        = string
}

variable "function_assume_role_policy_path" {
  description = "Path to the Lambda assume role policy JSON"
  type        = string
}

variable "handler" {
  description = "Handler for the Lambda function (e.g., file.function)"
  type        = string
}