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
                "kms:GenerateDataKey",
                "kms:GenerateDataKeyWithoutPlaintext",
                "kms:DescribeKey",
                "kms:CreateGrant",
                "kms:ListAliases"
            ],
            "Resource": [
                "arn:aws:kms:ap-south-1:xxxxxxxxxxxxxxx:key/xxxxxxxxxxxxxxx",
                "arn:aws:kms:ap-south-1:xxxxxxxxxxxxxxx:key/xxxxxxxxxxxxxxx"
            ]
        }
   ]
}
