variable "naming_prefix" {
  description = "A common prefix used for naming AWS resources to avoid conflicts"
}

variable "account_id" {
  description = "The AWS account ID where resources will be created"
}

variable "region" {
  description = "The AWS region where resources will be deployed"
}

variable "project_name1" {
  description = "The first project name used in EventBridge event pattern"
}

variable "project_image_uri1" {
  description = "The docker image uri of the first project"
}

variable "project_name2" {
  description = "The second project name used in EventBridge event pattern"
}

variable "project_image_uri2" {
  description = "The docker image uri of the second project"
}

variable "project_buildspec_path" {
  description = "Path to the buildspec.yml"
}

variable "project_assume_role_policy_path" {
  description = "Path to the assume role policy JSON used by CodeBuild IAM roles"
}

variable "bucket_policy_path" {
  description = "Path to the S3 bucket policy JSON file"
}

variable "function_assume_role_policy_path" {
  description = "Path to the assume role policy JSON used by Lambda IAM roles"
}

variable "inline_policy_tpl_path_trigger_build" {
  description = "Path to the inline IAM policy template used by the trigger build Lambda function"
}

variable "inline_policy_tpl_path_upload_log" {
  description = "Path to the inline IAM policy template used by the upload log Lambda function"
}

variable "function_trigger_build_zip_path" {
  description = "Path to the ZIP file containing the trigger build Lambda function code"
}

variable "function_upload_log_zip_path" {
  description = "Path to the ZIP file containing the upload log Lambda function code"
}

variable "event_pattern_trigger_build_path" {
  description = "Path to the JSON file defining the event pattern for the trigger build EventBridge rule"
}

variable "event_pattern_upload_log_path" {
  description = "Path to the JSON file defining the event pattern for the upload log EventBridge rule"
}

variable "rule_assume_role_policy_path" {
  description = "Path to the assume role trust policy JSON used by EventBridge rule IAM roles"
}

variable "function_policy_trigger_build_path" {
  description = "Path to the IAM policy JSON for the trigger build EventBridge rule target Lambda"
}

variable "function_policy_upload_log_path" {
  description = "Path to the IAM policy JSON for the upload log EventBridge rule target Lambda"
}

variable "function_invoke_policy_path" {
  description = "Path to the IAM policy JSON that grants permission to invoke a Lambda function"
}
