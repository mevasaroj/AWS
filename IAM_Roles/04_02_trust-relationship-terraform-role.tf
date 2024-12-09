{
  "Version": "2012-10-17",
  "Statement": [
     {
       "Effect": "Allow",
       "Principal": {
         "AWS": [
           "<Terraform_role_ARN>"
          ],
         "Service": "ec2.amazonaws.com"
       },
       "Action": "sts:AssumeRole",
       "Condition": {}
     }
  ]
}
