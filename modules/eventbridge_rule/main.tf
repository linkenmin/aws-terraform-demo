locals {
  role_name   = "${var.rule_name}-role"
  policy_name = "${var.rule_name}-policy"
}

resource "aws_cloudwatch_event_rule" "this" {
  name          = var.rule_name
  description   = var.description
  event_pattern = templatefile(var.event_pattern_file_path, {
    bucket_name   = var.bucket_name
    project_name1 = var.project_name1
    project_name2 = var.project_name2
  })
  state         = "ENABLED"
}

resource "aws_iam_role" "this" {
  name = local.role_name

  assume_role_policy = templatefile(
    var.rule_assume_role_policy_path,
    {
      account_id = var.account_id
      source_arn = "arn:aws:events:${var.region}:${var.account_id}:rule/${aws_cloudwatch_event_rule.this.name}"
    }
  )
}

resource "aws_iam_role_policy" "this" {
  name = local.policy_name
  role = aws_iam_role.this.id

  policy = templatefile(
    var.role_policy_file_path,
    {
      region               = var.region
      account_id           = var.account_id
      function_name = var.function_name
    }
  )
}

resource "aws_cloudwatch_event_target" "this" {
  rule      = aws_cloudwatch_event_rule.this.name
  target_id = var.function_target_id
  arn       = var.function_target_arn
  role_arn  = aws_iam_role.this.arn
}
