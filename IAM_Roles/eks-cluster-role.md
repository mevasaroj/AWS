# eks-cluster-role

- Sign in to the AWS Management Console and open the IAM console at https://console.aws.amazon.com/iam/
  
- In the navigation pane of the IAM console, choose __Roles__, and then choose __Create role__.
  
- Under = Select Trusted entity type
   - Trusted entity type : **AWS service**
   - Use cases : type **"EKS"** --> Select __"EKS Cluster"__ --> Second Option
     
 - Under Add permission : **(Default)** --> No Changes
   
 - Under Name, review, and create
   - Role Name : **eks-cluster-role**
   - Description : __No Changes__
   - Step 1: Select trusted entities : __No Changes__
   - Step 2: Add permissions: __No Changes__
   - Step 3: Add Tags : Add the require tags
     
 - Click **Create role**

# Add KMS Key Policy to Above eks-cluster-role
- Sign in to the AWS Management Console and open the IAM console at https://console.aws.amazon.com/iam/
- Below __Access management__ (Left Pane) --> Click **Roles**
- Select **eks-cluster-role** from list
- Under __Permission__ --> Click **Add Permission** --> Click **Attach Policies**
- Type __KMS__ in search --> Select (Check Mark) Policy --> Click **Add Permision**
