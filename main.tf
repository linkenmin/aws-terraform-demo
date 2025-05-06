provider "aws" {
  region = var.region
}

locals {
  bucket_name                   = "${var.naming_prefix}-bucket"

  rule_trigger_build_name       = "${var.naming_prefix}-rule-trigger-build"
  rule_upload_log_name          = "${var.naming_prefix}-rule-upload-log"
  function_trigger_build_name   = "${var.naming_prefix}-function-trigger-build"
  function_upload_log_name      = "${var.naming_prefix}-function-upload-log"
  codebuild_service_role_arn1   = "arn:aws:iam::${var.account_id}:role/codebuild-$(var.project_name1)-service-role"
  codebuild_service_role_arn2   = "arn:aws:iam::${var.account_id}:role/codebuild-$(var.project_name2)-service-role"
  function_trigger_build_arn    = "arn:aws:lambda:${var.region}:${var.account_id}:function:${local.function_trigger_build_name}"
  function_upload_log_arn       = "arn:aws:lambda:${var.region}:${var.account_id}:function:${local.function_upload_log_name}"
}

module "s3_bucket" {
  source = "./modules/s3_bucket"

  bucket_name = local.bucket_name
  bucket_policy_path = var.bucket_policy_path
}

module "project_jsonplaceholder" {
  source = "./modules/codebuild_project"

  bucket_name                       = local.bucket_name
  service_role_arn                  = local.codebuild_service_role_arn1
  account_id                        = var.account_id
  region                            = var.region
  project_name                      = var.project_name1
  image_uri                         = var.project_image_uri1
  buildspec_path                    = var.project_buildspec_path
  project_assume_role_policy_path   = var.project_assume_role_policy_path
}

module "project_practicetestautomation" {
  source = "./modules/codebuild_project"

  bucket_name                       = local.bucket_name
  service_role_arn                  = local.codebuild_service_role_arn2
  account_id                        = var.account_id
  region                            = var.region
  project_name                      = var.project_name2
  image_uri                         = var.project_image_uri2
  buildspec_path                    = var.project_buildspec_path
  project_assume_role_policy_path   = var.project_assume_role_policy_path
}

module "function_trigger_build" {
  source                            = "./modules/lambda_function"

  function_name                     = local.function_trigger_build_name
  bucket_name                       = local.bucket_name
  account_id                        = var.account_id
  region                            = var.region
  project_name1                     = var.project_name1
  project_name2                     = var.project_name2
  zip_file_path                     = var.function_trigger_build_zip_path
  inline_policy_path                = var.inline_policy_tpl_path_trigger_build
  function_assume_role_policy_path  = var.function_assume_role_policy_path
  handler                           = "function_trigger_build.lambda_handler"
}

module "function_upload_log" {
  source                            = "./modules/lambda_function"

  function_name                     = local.function_upload_log_name
  bucket_name                       = local.bucket_name
  account_id                        = var.account_id
  region                            = var.region
  project_name1                     = var.project_name1
  project_name2                     = var.project_name2
  zip_file_path                     = var.function_upload_log_zip_path
  inline_policy_path                = var.inline_policy_tpl_path_upload_log
  function_assume_role_policy_path  = var.function_assume_role_policy_path
  handler                           = "function_upload_log.lambda_handler"
}

module "eventbridge_trigger_build" {
  source                        = "./modules/eventbridge_rule"

  description                   = "Triggered when product.zip uploaded to S3"
  bucket_name                   = local.bucket_name
  rule_name                     = local.rule_trigger_build_name
  function_name                 = local.function_trigger_build_name
  function_target_arn           = local.function_trigger_build_arn
  account_id                    = var.account_id
  region                        = var.region
  project_name1                 = var.project_name1
  project_name2                 = var.project_name2
  event_pattern_file_path       = var.event_pattern_trigger_build_path
  rule_assume_role_policy_path  = var.rule_assume_role_policy_path
  role_policy_file_path         = var.function_invoke_policy_path
  function_target_id            = "trigger-build-target-id"
}

module "eventbridge_upload_log" {
  source                        = "./modules/eventbridge_rule"

  description                   = "Triggered when CodeBuild finishes"
  bucket_name                   = local.bucket_name
  rule_name                     = local.rule_upload_log_name
  function_name                 = local.function_upload_log_name
  function_target_arn           = local.function_upload_log_arn
  account_id                    = var.account_id
  region                        = var.region
  project_name1                 = var.project_name1
  project_name2                 = var.project_name2
  event_pattern_file_path       = var.event_pattern_upload_log_path
  rule_assume_role_policy_path  = var.rule_assume_role_policy_path
  role_policy_file_path         = var.function_invoke_policy_path
  function_target_id            = "upload-log-target-id"
}
