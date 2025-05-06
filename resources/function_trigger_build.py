import boto3
import json
import datetime
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

codebuild = boto3.client('codebuild')

def lambda_handler(event, context):
    print(json.dumps(event))

    now = datetime.datetime.utcnow()
    datetime_str = now.strftime('%Y-%m-%d_%H-%M-%S')

    try:
        key = event['detail']['object']['key']
        parts = key.split('/')
        
        if len(parts) != 3 or parts[-1] != 'product.zip':
            logger.error(f"Invalid key format: {key}. Expected format: project/version/product.zip")
            return {
                'statusCode': 400,
                'body': f"Invalid key format: {key}"
            }

        project = parts[0]
        version = parts[1]

        if not project or not version:
            logger.error(f"Project or version is empty in key: {key}")
            return {
                'statusCode': 400,
                'body': f"Project or version is missing in key: {key}"
            }

    except KeyError:
        logger.error("Missing 'object.key' in event")
        return {
            'statusCode': 400,
            'body': "Missing 'object.key' in event"
        }

    response = codebuild.start_build(
        projectName=project,
        environmentVariablesOverride=[
            {'name': 'VERSION', 'value': version, 'type': 'PLAINTEXT'},
            {'name': 'DATETIME', 'value': datetime_str, 'type': 'PLAINTEXT'},
        ]
    )

    build_id = response['build']['id']
    logger.info("Build started for project: %s, version: %s", project, version)

    return {
        'statusCode': 200,
        'body': f"Build triggered for {project}/{version} at {datetime_str}. Build ID: {build_id}"
    }
