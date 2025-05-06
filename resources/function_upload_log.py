import boto3
import json

s3_client = boto3.client("s3")
logs_client = boto3.client("logs")
codebuild = boto3.client("codebuild")

def lambda_handler(event, context):
    print(json.dumps(event))

    build_status = event.get("detail", {}).get("build-status", "unknown_status")
    project_name = event.get("detail", {}).get("project-name", "unknown_project")
    build_id = event.get("detail", {}).get("build-id", "unknown_build_id")

    env_vars = event.get("detail", {}).get("additional-information", {}).get("environment", {}).get("environment-variables", [])
    s3_bucket = next((v["value"] for v in env_vars if v.get("name") == "S3_BUCKET"), "unknown_s3")
    version = next((v["value"] for v in env_vars if v.get("name") == "VERSION"), "unknown_version")
    dt = next((v["value"] for v in env_vars if v.get("name") == "DATETIME"), "unknown_datetime")

    print(f"Build status: {build_status}, S3: {s3_bucket}, Project: {project_name}, Version: {version}, Datetime: {dt}, Build ID: {build_id}")

    try:
        build_info = codebuild.batch_get_builds(ids=[build_id])["builds"][0]
        log_group = build_info["logs"]["groupName"]
        log_stream = build_info["logs"]["streamName"]
    except Exception as e:
        print(f"Failed to fetch log info from build ID: {e}")
        return

    try:
        log_events = logs_client.get_log_events(
            logGroupName=log_group,
            logStreamName=log_stream,
            startFromHead=True
        )
        log_lines = [event["message"] for event in log_events["events"]]
        log_text = "\n".join(log_lines)
    except Exception as e:
        print(f"Failed to fetch logs from CloudWatch: {e}")
        return

    s3_key = f"{project_name}/{version}/{dt}/build-{build_status.lower()}.txt"
    try:
        s3_client.put_object(
            Bucket=s3_bucket,
            Key=s3_key,
            Body=log_text.encode("utf-8"),
            ContentType="text/plain"
        )
        print(f"Uploaded CodeBuild log to s3://{s3_bucket}/{s3_key}")
    except Exception as e:
        print(f"Failed to upload to S3: {e}")
