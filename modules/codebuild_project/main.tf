resource "aws_iam_role" "codebuild_role" {
  name               = "codebuild-${var.project_name}-service-role"
  assume_role_policy = file(var.project_assume_role_policy_path)
}

resource "aws_iam_role_policy_attachment" "cloudwatch" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
}

resource "aws_iam_role_policy_attachment" "ecr" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "s3" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_codebuild_project" "this" {
  name          = var.project_name
  description   = "CodeBuild project for ${var.project_name}"
  service_role  = aws_iam_role.codebuild_role.arn
  build_timeout = 60
  queued_timeout = 480

  source {
    type      = "NO_SOURCE"
    buildspec = file(var.buildspec_path)
  }

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_MEDIUM"
    image                       = "aws/codebuild/amazonlinux-x86_64-standard:5.0"
    type                        = "LINUX_CONTAINER"
    privileged_mode             = true
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "ACCOUNT_ID"
      value = var.account_id
    }

    environment_variable {
      name  = "REGION"
      value = var.region
    }

    environment_variable {
      name  = "VERSION"
      value = "default_version"
    }

    environment_variable {
      name  = "DATETIME"
      value = "default_datetime"
    }

    environment_variable {
      name  = "PROJECT"
      value = var.project_name
    }

    environment_variable {
      name  = "IMAGE_URI"
      value = var.image_uri
    }

    environment_variable {
      name  = "S3_BUCKET"
      value = var.bucket_name
    }

  }

  logs_config {
    cloudwatch_logs {
      status = "ENABLED"
    }
    s3_logs {
      status              = "DISABLED"
      encryption_disabled = false
    }
  }
}
