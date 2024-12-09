
# Create Custom Ingress Policy
- Sign in to the AWS Management Console and open the IAM console at https://console.aws.amazon.com/iam/
- In the navigation pane of the IAM console, Expand __Access management__ (Left panel) choose __Roles__, and then choose __Create policy__.
- Click on JSON 
- Copy and paste the Policy from https://github.com/mevasaroj/AWS/blob/main/IAM_Roles/07_01_policy-ingress.tf
- Click __Next__
- Under **Review and create** 
   - Policy Name : **ingress_policy**
   - Description : **ingress_policy**
   - Add Tags : Add require tags 
- Click __Create Policy__



# Create ingress-role
- Sign in to the AWS Management Console and open the IAM console at https://console.aws.amazon.com/iam/
- In the navigation pane of the IAM console, Expand __Access management__ (Left panel) choose __Roles__, and then choose __Create role__.
  
- Under : **Select Trusted entity type**
   - Trusted entity type : **AWS service**
   - Use cases : type __"ec2"__ --> Select __"ec2"__ --> First Option
   - Click __Next__
 
- Under **Add permission** --> Type **ingress_policy** & Check Mark it --> Click __Next__

        
- Under **Name, review, and create**
   - Role Name : **ingress-role**
   - Description : **ingress-role**
   - Step 1: Select trusted entities : __No Changes__
   - Step 2: Add permissions: __No Changes__
   - Step 3: Add Tags : Add the require tags

- Click **create role**



# Update the Trust relationship to ingress-role
- Sign in to the AWS Management Console and open the IAM console at https://console.aws.amazon.com/iam/
- Below __Access management__ (Left Pane) --> Click **Roles**
- Select **terafform-role** from list
- Click **Trust relationships**
- Copy and paste the content from https://github.com/mevasaroj/AWS/blob/main/IAM_Roles/07_02_trust-relationship-ingress.tf
