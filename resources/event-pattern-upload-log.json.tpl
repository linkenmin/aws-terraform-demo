{
    "source": ["aws.codebuild"],
    "detail-type": ["CodeBuild Build State Change"],
    "detail": {
        "build-status": ["SUCCEEDED", "FAILED", "STOPPED"],
        "project-name": ["${project_name1}", "${project_name2}"]
    }
}
