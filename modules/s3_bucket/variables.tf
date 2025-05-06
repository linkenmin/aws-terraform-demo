variable "bucket_name" {
  description = "The name of the S3 bucket to be created."
  type        = string
}

variable "bucket_policy_path" {
  description = "Path to the JSON file used as the S3 bucket policy template."
  type        = string
}