def lambda_handler(event, context):
    return {
        "isBase64Encoded": False,
        "headers": {
            "Content-Type": "application/json ; charset=utf-8",
            "Access-Control-Allow-Origin": "*"
        },
        "statusCode": 200,
        "body": "Success!"
    }
