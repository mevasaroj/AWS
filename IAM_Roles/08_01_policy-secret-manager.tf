{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "KMSAccess",
            "Effect": "Allow",
            "Action": [
                "kms:ListGrants",
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:DescribeKey",
                "kms:CreateGrant",
                "kms:GenerateDataKey*",
                "kms:ListAliases"
            ],
            "Resource": [
                "arn:aws:kms:ap-south-1:xxxxxxxxxx:key/xxxxxxxxxxxxxxxxx"
            ],
            "Condition": {
                "StringEquals": {
                    "aws:RequestedRegion": "ap-south-1"
                }
            }
        },
        {
            "Effect": "Allow",
            "Action": [
                "secretsmanager:GetSecretValue",
                "secretsmanager:DescribeSecret"
            ],
            "Resource": [ 
		"*" 
	    ],
            "Condition": {
                "StringEquals": {
                    "aws:RequestedRegion": "ap-south-1"
                }
            }
        }
    ]
}
