{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
                 "AWS": "<WorkerNode_Role_ARN>"
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
                 "AWS": "arn:aws:iam::xxxxxxx:role/eks-workernode-role"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
===============================================================================
