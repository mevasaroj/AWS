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
                "Federated": "arn:aws:iam::416385516723:oidc-provider/oidc.eks.ap-south-1.amazonaws.com/id/1706812077B88376304B44CD2D493D6F"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "oidc.eks.ap-south-1.amazonaws.com/id/1706812077B88376304B44CD2D493D6F:aud": "sts.amazonaws.com"
                }
            }
        }
    ]
}
