
# Create Custom secret manager Policy
- Sign in to the AWS Management Console and open the IAM console at https://console.aws.amazon.com/iam/
- In the navigation pane of the IAM console, Expand __Access management__ (Left panel) choose __Policy__, and then choose __Create policy__.
- Click on JSON 
- Copy and paste the Policy from https://github.com/mevasaroj/AWS/blob/main/IAM_Roles/08_01_policy-secret-manager.tf
- Click __Next__
- Under **Review and create** 
   - Policy Name : **secret_manager_policy**
   - Description : **secret_manager_policy**
   - Add Tags : Add require tags 
- Click __Create Policy__



# Create ingress-role
- Sign in to the AWS Management Console and open the IAM console at https://console.aws.amazon.com/iam/
- In the navigation pane of the IAM console, Expand __Access management__ (Left panel) choose __Roles__, and then choose __Create role__.
  
- Under : **Select Trusted entity type**
   - Trusted entity type : **AWS service**
   - Use cases : type __"ec2"__ --> Select __"ec2"__ --> First Option
   - Click __Next__
 
- Under **Add permission** --> Type **secret_manager_policy** & Check Mark it --> Click __Next__

        
- Under **Name, review, and create**
   - Role Name : **secret_manager-role**
   - Description : **secret_manager-role**
   - Step 1: Select trusted entities : __No Changes__
   - Step 2: Add permissions: __No Changes__
   - Step 3: Add Tags : Add the require tags

- Click **create role**



# Update the Trust relationship to ingress-role
- Sign in to the AWS Management Console and open the IAM console at https://console.aws.amazon.com/iam/
- Below __Access management__ (Left Pane) --> Click **Roles**
- Select **secret_manager-role** from list
- Click **Trust relationships**
- Copy and paste the content from https://github.com/mevasaroj/AWS/blob/main/IAM_Roles/08_02_trust-relationship-secret-manager.tf
