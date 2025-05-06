variable "account_id" {
  description = "AWS account ID"
  type        = string
}

variable "region" {
  description = "The AWS region where resources will be deployed"
}

variable "project_name" {
  description = "The name of the CodeBuild project"
  type        = string
}

variable "image_uri" {
  description = "The ECR image URI to be used in the build phase"
  type        = string
}

variable "bucket_name" {
  description = "The S3 bucket name where the test reports will be uploaded"
  type        = string
}

variable "buildspec_path" {
  description = "Path to the buildspec YAML file used by this project"
  type        = string
}

variable "service_role_arn" {
  description = "IAM service role ARN for CodeBuild to use"
  type        = string
}

variable "project_assume_role_policy_path" {
  description = "Path to the assume role trust policy JSON"
  type        = string
}