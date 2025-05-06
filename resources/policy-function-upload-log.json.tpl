{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "codebuild:BatchGetBuilds"
            ],
            "Resource": [
                "arn:aws:codebuild:${region}:${account_id}:project/${project_name1}",
                "arn:aws:codebuild:${region}:${account_id}:project/${project_name2}"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "logs:DescribeLogGroups",
                "logs:DescribeLogStreams",
                "logs:GetLogEvents"
            ],
            "Resource": [
                "arn:aws:logs:*:*:log-group:/aws/codebuild/*",
                "arn:aws:logs:*:*:log-group:/aws/lambda/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject"
            ],
            "Resource": "arn:aws:s3:::${bucket_name}/*"
        }
    ]
}