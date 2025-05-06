{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "AllowPublicReadForReports",
        "Effect": "Allow",
        "Principal": "*",
        "Action": "s3:GetObject",
        "Resource": [
          "arn:aws:s3:::${bucket_name}/*.html",
          "arn:aws:s3:::${bucket_name}/*.txt",
          "arn:aws:s3:::${bucket_name}/*.xml"
        ]
      }
    ]
  }
  