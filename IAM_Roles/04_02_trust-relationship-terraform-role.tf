{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
                 "AWS": "<Terraform_role_ARN>"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
===============================================================================
Example:
--------------
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
                 "AWS": "arn:aws:iam::xxxxxxx:role/terafform-role"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
