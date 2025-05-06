# aws-terraform-demo

This is a fully automated and event-driven CI/CD infrastructure project built with Terraform on AWS. It complements two lightweight automation testing projects:

- [jsonplaceholder-demo](https://github.com/linkenmin/jsonplaceholder-demo)
- [practicetestautomation-demo](https://github.com/linkenmin/practicetestautomation-demo)

These two repositories demonstrate API and web UI automation testing using Java + Cucumber, and are pre-packaged as Docker images. This Terraform project is designed to orchestrate their execution on AWS using S3, ECR, Lambda, CodeBuild, and CloudWatch.

> You can also replace these demo projects with your own Dockerized test projects by customizing the variables in `terraform.tfvars`.

---

## Features

- Upload a `product.zip` file to a specific S3 path to **automatically trigger** the corresponding test execution codebuild.
- Each project is executed using its **dedicated CodeBuild project**, dynamically injected with parameters such as version and timestamp.
- Test results are uploaded to S3, including:
  - `cucumber-report.html`
  - `surefire-reports/` (JUnit XML results)
  - `build-{succeeded|failed}.txt` summary log
- Uses **CloudWatch logs** + S3 archiving for centralized traceability.
- Easily extendable: Add new test projects by simply defining variables and reusing existing modules.

---

## Project Structure

```
.
├── main.tf                     # Root Terraform setup
├── terraform.tfvars            # User-defined variables
├── variables.tf                # Defined Variables
├── modules/
│   ├── codebuild_project/      # CodeBuild project for running test cases
│   ├── eventbridge_rule/       # EventBridge rules for trigger-build or upload-log
│   ├── lambda_function/        # Lambda functions for trigger-build or upload-log
│   └── s3_bucket/              # S3 bucket for trigger-build and upload-log
└── resources/                  # buildspec.yml, python lambda functions and policy json files
```

---

## How to Use

### 1. Prerequisites

Before applying this Terraform project, make sure you:

- Have your test projects containerized and pushed to AWS ECR.
- Know your AWS region and account ID.
- Have Terraform installed.

> The sample test projects can be found here:
> - [jsonplaceholder-demo](https://github.com/linkenmin/jsonplaceholder-demo)
> - [practicetestautomation-demo](https://github.com/linkenmin/practicetestautomation-demo)

---

### 2. Configure `terraform.tfvars`

Edit `terraform.tfvars` to customize:

```hcl
naming_prefix = "your-prefix"
region        = "your-region-1" # Replace with the region you want
account_id    = "123456789012"  # Replace with your own AWS account ID

# Define your test project info
project_name1        = "jsonplaceholder"
project_image_uri1   = "123456789012.dkr.ecr.your-region-1.amazonaws.com/jsonplaceholder-demo:latest"

project_name2        = "practicetestautomation"
project_image_uri2   = "123456789012.dkr.ecr.your-region-1.amazonaws.com/practicetestautomation-demo:latest"
```

---

### 3. Deploy with Terraform

```bash
terraform init
terraform plan -out=tfplan -var-file=terraform.tfvars
terraform apply "tfplan"
```

This will provision:

- An S3 bucket for artifacts
- Two CodeBuild projects (jsonplaceholder & practicetestautomation)
- Two EventBridge rules (trigger-build & upload-log)
- Two Lambda function (trigger-build & upload-log)

---

### 4. Trigger a Test

To run a test:

1. Upload a `product.zip` to the following S3 path format:

   ```
   s3://<your-bucket>/<project_name>/<version>/product.zip
   ```

   Example:

   ```
   s3://my-bucket/jsonplaceholder/1.0.0/product.zip
   ```

2. This will automatically trigger the test for `jsonplaceholder`, and create a folder like:

   ```
   s3://my-bucket/jsonplaceholder/1.0.0/2025-04-20_14-30-00/
   ```

   Inside you will find:

   - `cucumber-report.html`
   - `surefire-reports/`
   - `build-succeeded.txt` or `build-failed.txt`

3. You can track logs in CloudWatch or use the S3 `build-*.txt` as a simple report indicator.

---

## Customization

- Add new test projects by appending to `test_projects` in `terraform.tfvars`.
- Modify build logic via your custom `buildspec.yml`.
- All IAM policies and Lambda logic are modular and customizable.

---

## Why This Is Useful

This architecture is ideal for:

- Integration testing on every new build
- Plug-and-play test execution across multiple projects
- Fully automated CI/CD with clear logs and report uploads
- Minimal infrastructure effort with Terraform-as-code
