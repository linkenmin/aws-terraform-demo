{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "codebuild:StartBuild",
                "codebuild:BatchGetBuilds"
            ],
            "Resource": [
                "arn:aws:codebuild:${region}:${account_id}:project/${project_name1}",
                "arn:aws:codebuild:${region}:${account_id}:project/${project_name2}"
            ]
        }
    ]
}