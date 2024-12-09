# EKS Cluster IAM Roles

1. Sign in to the AWS Management Console and open the IAM console at https://console.aws.amazon.com/iam/


2. In the navigation pane of the IAM console, choose Roles, and then choose Create role.

3. Select the Following : 
	     Trusted entity type : AWS Service
	     Use case : under Use cases for other AWS services: Type EKS

4. Select "EKS Cluster" - 2nd Option --> Click Next

5. Under Add permission : (Default) --> No Changes

6. Name, review, and create	
	     Role name : hbl-aws-aps1-appname-uat-eks-cluster-role
	     Tags:
	         Name : eks-cluster-role
	         Environment : uat

7. Click Create Roles
