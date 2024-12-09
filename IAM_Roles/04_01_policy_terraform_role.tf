{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "FullAccess",
            "Effect": "Allow",
            "Action": [
                "acm:*",
                "apigateway:*",
                "autoscaling:*",
                "application-autoscaling:*",
                "backup:*",
                "cloudtrail:*",
                "cloudwatch:*",
                "dax:*",
                "dlm:*",
                "dynamodb:*",
                "datasync:*",
                "ec2:*",
                "ec2messages:*",
                "elasticache:*",
                "elasticloadbalancing:*",
                "elasticfilesystem:*",
                "eks:*",
                "ebs:*",
                "es:*",
                "globalaccelerator:*",
                "glacier:*",
                "kafka:*",
                "kinesis:*",
                "logs:*",
                "lambda:*",
                "mq:*",
                "rds:*",
                "s3:*",
                "ses:*",
                "sns:*",
                "sqs:*",
                "ssm:*",
                "secretsmanager:*",
                "ssmmessages:*",
                "storagegateway:*",
                "tag:*",
                "ds:CreateComputer",
                "ds:DescribeDirectories",
                "sts:DecodeAuthorizationMessage"
            ],
            "Resource": "*"
        },
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
            ],
        },
        {
            "Sid": "AllowServiceLinkRoleCreation",
            "Effect": "Allow",
            "Action": "iam:CreateServiceLinkedRole",
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "iam:AWSServiceName": [
                        "acm.amazonaws.com",
                        "application-autoscaling.amazonaws.com",
                        "application-autoscaling.amazonaws.com.cn",
                        "apigateway.amazonaws.com",
                        "autoscaling.amazonaws.com",
                        "contributorinsights.dynamodb.amazonaws.com",
                        "cloudwatch.amazonaws.com",
                        "dax.amazonaws.com",
                        "dynamodb.application-autoscaling.amazonaws.com",
                        "ec2.amazonaws.com",
                        "ec2scheduled.amazonaws.com",
                        "elasticloadbalancing.amazonaws.com",
                        "eks.amazonaws.com",
                        "eks-fargate-pods.amazonaws.com",
                        "eks-nodegroup.amazonaws.com",
                        "es.amazonaws.com",
                        "elasticache.amazonaws.com",
                        "spot.amazonaws.com",
                        "spotfleet.amazonaws.com",
                        "transitgateway.amazonaws.com",
                        "rds.application-autoscaling.amazonaws.com",
                        "rds.amazonaws.com",
                        "ssm.amazonaws.com",
                        "replication.dynamodb.amazonaws.com",
                        "kinesisreplication.dynamodb.amazonaws.com",
                        "elasticfilesystem.amazonaws.com",
                        "globalaccelerator.amazonaws.com",
                        "monitoring.rds.amazonaws.com",
                        "mq.amazonaws.com",
                        "kafka.amazonaws.com",
                        "lambda.amazonaws.com"
                    ]
                }
            }
        },
        {
            "Sid": "IAMPassAccess",
            "Effect": "Allow",
            "Action": "iam:PassRole",
            "Resource": "*",
            "Condition": {
                "StringLike": {
                    "iam:PassedToService": [
                        "acm.amazonaws.com",
                        "apigateway.amazonaws.com",
                        "application-autoscaling.amazonaws.com",
                        "application-autoscaling.amazonaws.com.cn",
                        "autoscaling.amazonaws.com",
                        "contributorinsights.dynamodb.amazonaws.com",
                        "cloudwatch.amazonaws.com",
                        "dax.amazonaws.com",
                        "datasync.amazonaws.com",
                        "dynamodb.application-autoscaling.amazonaws.com",
                        "ec2.amazonaws.com",
                        "ec2scheduled.amazonaws.com",
                        "elasticloadbalancing.amazonaws.com",
                        "eks.amazonaws.com",
                        "eks-fargate-pods.amazonaws.com",
                        "eks-nodegroup.amazonaws.com",
                        "es.amazonaws.com",
                        "elasticache.amazonaws.com",
                        "spot.amazonaws.com",
                        "spotfleet.amazonaws.com",
                        "storagegateway.amazonaws.com",
                        "transitgateway.amazonaws.com",
                        "rds.application-autoscaling.amazonaws.com",
                        "rds.amazonaws.com",
                        "ssm.amazonaws.com",
                        "replication.dynamodb.amazonaws.com",
                        "kinesisreplication.dynamodb.amazonaws.com",
                        "elasticfilesystem.amazonaws.com",
                        "globalaccelerator.amazonaws.com",
                        "monitoring.rds.amazonaws.com",
                        "mq.amazonaws.com",
                        "kafka.amazonaws.com",
                        "lambda.amazonaws.com"
                    ]
                }
            }
        },
        {
            "Sid": "IAMOIDCAccess",
            "Effect": "Allow",
            "Action": [
                "iam:CreateOpenIDConnectProvider",
                "iam:DeleteOpenIDConnectProvider",
                "iam:UpdateOpenIDConnectProviderThumbprint"
            ],
            "Resource": "*"
        },
        {
            "Sid": "IAMLimitAccess",
            "Effect": "Allow",
            "Action": [
                "iam:Generate*",
                "iam:Get*",
                "iam:List*",
                "iam:Tag*",
                "iam:Untag*",
                "iam:Put*",
                "iam:SimulateCustomPolicy",
                "iam:SimulatePrincipalPolicy",
                "iam:DeleteInstanceProfile",
                "iam:RemoveRoleFromInstanceProfile",
                "iam:AttachRolePolicy",
                "iam:AddRoleToInstanceProfile",
                "iam:DeleteServiceLinkedRole"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:DeleteServiceLinkedRole",
                "iam:GetServiceLinkedRoleDeletionStatus"
            ],
            "Resource": [
                "arn:aws:iam::*:role/aws-service-role/acm.amazonaws.com/AWSServiceRoleForCertificateManager*",
                "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM*"
            ]
        },
        {
            "Sid": "DenySecurityGroupModification",
            "Effect": "Deny",
            "Action": [
                "ec2:ModifySecurityGroupRules",
                "ec2:CreateSecurityGroup"
            ],
            "Resource": "*"
        },
        {
            "Sid": "RequireIMDSv2",
            "Effect": "Deny",
            "Action": "ec2:RunInstances",
            "Resource": "arn:aws:ec2:*:*:instance/*",
            "Condition": {
                "StringNotEquals": {
                    "ec2:MetadataHttpTokens": "required"
                }
            }
        },
        {
            "Sid": "VolumeType",
            "Effect": "Deny",
            "Action": "ec2:*",
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "ec2:VolumeType": [
                        "gp2",
                        "io1",
                        "io2",
                        "sc1",
                        "st1"
                    ]
                }
            }
        }
    ]
}
