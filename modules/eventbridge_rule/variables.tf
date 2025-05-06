variable "bucket_name" {
  description = "Name of the S3 bucket used in the event pattern"
  type        = string
}

variable "project_name1" {
  description = "Project name 1"
  type        = string
}

variable "project_name2" {
  description = "Project name 2"
  type        = string
}

variable "rule_name" {
  description = "The name of the EventBridge rule"
  type        = string
}

variable "description" {
  description = "Description for the EventBridge rule"
  type        = string
}

variable "function_target_arn" {
  description = "ARN of the Lambda function that is the target of the rule"
  type        = string
}

variable "function_target_id" {
  description = "Unique target ID for the Lambda in EventBridge rule"
  type        = string
}

variable "account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "event_pattern_file_path" {
  description = "Path to the event pattern JSON file"
  type        = string
}

variable "rule_assume_role_policy_path" {
  description = "Path to the assume role trust policy JSON"
  type        = string
}

variable "role_policy_file_path" {
  description = "Path to the IAM role policy JSON"
  type        = string
}

variable "function_name" {
  description = "Name of the Lambda function for use in resource ARNs"
  type        = string
}

variable "region" {
  description = "AWS region (used for constructing ARNs)"
  type        = string
}
