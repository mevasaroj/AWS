{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "<CLUSTER_OIDC_ARN>"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "oidc.eks.ap-south-1.amazonaws.com/id/<CLUSTER_OIDC_ID>:aud": "sts.amazonaws.com"
                }
            }
        }
    ]
}

--------------------------------------------------------------------
Example -- Find OIDC ARN --> Click --> IAM --> Identity providers
--------------------------------------------------------------------
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::230068362696:oidc-provider/oidc.eks.ap-south-1.amazonaws.com/id/31AE0B3CB1CD2C2C2F42FE91B9435476"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "oidc.eks.ap-south-1.amazonaws.com/id/31AE0B3CB1CD2C2C2F42FE91B9435476:aud": "sts.amazonaws.com"
                }
            }
        }
    ]
}
