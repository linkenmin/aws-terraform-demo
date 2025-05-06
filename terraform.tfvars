naming_prefix = "kenmin"

account_id = "089819418105"
region = "ap-southeast-2"

project_name1                           = "jsonplaceholder"
project_image_uri1                      = "089819418105.dkr.ecr.ap-southeast-2.amazonaws.com/jsonplaceholder-demo:latest"

project_name2                           = "practicetestautomation"
project_image_uri2                      = "089819418105.dkr.ecr.ap-southeast-2.amazonaws.com/practicetestautomation-demo:latest"

bucket_policy_path                      = "./resources/bucket_policy.json.tpl"

project_buildspec_path                  = "./resources/buildspec.yml"
project_assume_role_policy_path         = "./resources/assume-project.json"

function_trigger_build_zip_path         = "./resources/function_trigger_build.zip"
function_upload_log_zip_path            = "./resources/function_upload_log.zip"

function_assume_role_policy_path        = "./resources/assume-function.json"
rule_assume_role_policy_path            = "./resources/assume-rule.json"

inline_policy_tpl_path_trigger_build    = "./resources/policy-function-trigger-build.json.tpl"
inline_policy_tpl_path_upload_log       = "./resources/policy-function-upload-log.json.tpl"

event_pattern_trigger_build_path        = "./resources/event-pattern-trigger-build.json.tpl"
event_pattern_upload_log_path           = "./resources/event-pattern-upload-log.json.tpl"

function_policy_trigger_build_path      = "./resources/policy-function-trigger-build.json.tpl"
function_policy_upload_log_path         = "./resources/policy-function-upload-log.json.tpl"

function_invoke_policy_path             = "./resources/policy-rule-function.json.tpl"
