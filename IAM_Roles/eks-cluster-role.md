# eks-cluster-role

 - Sign in to the AWS Management Console and open the IAM console at https://console.aws.amazon.com/iam/
 - In the navigation pane of the IAM console, choose Roles, and then choose Create role.
 - Under = Select Trusted entity type
   - Trusted entity type : AWS service
   - Use cases : type "EKS" --> Select "EKS Service" --> First Option
 - Under Add permission : (Default) --> No Changes
 - Under Name, review, and create : Default = AWSServiceRoleForAmazonEKS --> No Changes
 - Create role
