def lambda_handler(event, context):
    return {
        "policyDocument": {
            "Version": "2012-10-17",
            "Statement": [
                {
                    "Effect": "Allow",
                    "Action": [
                        "execute-api:Invoke"
                    ],
                    "Resource": [event['methodArn']]
                }
            ]
        }
    }
