locals {
  role_name   = "${var.function_name}-role"
  policy_name = "${var.function_name}-policy"
}

resource "aws_iam_role" "lambda_exec_role" {
  name               = local.role_name
  description        = "IAM role assumed by Lambda function ${var.function_name}"
  assume_role_policy = file(var.function_assume_role_policy_path)
}

resource "aws_iam_role_policy" "lambda_inline_policy" {
  name   = local.policy_name
  role   = aws_iam_role.lambda_exec_role.id
  policy = templatefile(var.inline_policy_path, {
    region        = var.region,
    account_id    = var.account_id,
    project_name1 = var.project_name1,
    project_name2 = var.project_name2,
    bucket_name   = var.bucket_name
  })
}

resource "aws_lambda_function" "lambda_func" {
  function_name = var.function_name
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = var.handler
  runtime       = "python3.12"

  filename         = var.zip_file_path
  source_code_hash = filebase64sha256(var.zip_file_path)
}
