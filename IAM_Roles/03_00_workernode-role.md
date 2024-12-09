# Create WorkerNode-role
- Sign in to the AWS Management Console and open the IAM console at https://console.aws.amazon.com/iam/
- In the navigation pane of the IAM console, Expand __Access management__ (Left panel) choose __Roles__, and then choose __Create role__.
  
- Under : **Select Trusted entity type**
   - Trusted entity type : **AWS service**
   - Use cases : type __"ec2"__ --> Select __"ec2"__ --> First Option
   - Under **Add permission** : Add Following Permission policies
      - AmazonEKSWorkerNodePolicy
      - AmazonEC2ContainerRegistryReadOnly
      - AmazonSSMManagedInstanceCore
      - AmazonEKS_CNI_Policy
      - AmazonEFSCSIDriverPolicy --> Optional for EFS if same role using for EFS for Pods as external Device
      - AmazonEBSCSIDriverPolicy --> Optional for EBS if same role using for EBS for Pods as external Device
      - AmazonEC2RoleforSSM --> Optional for SSM
        
- Under **Name, review, and create**
   - Role Name : **eks-workernode-role**
   - Description : __No Changes__
   - Step 1: Select trusted entities : __No Changes__
   - Step 2: Add permissions: __No Changes__
   - Step 3: Add Tags : Add the require tags

- Click **create role**


# Create Custom KMS Key Policy
- Sign in to the AWS Management Console and open the IAM console at https://console.aws.amazon.com/iam/
- In the navigation pane of the IAM console, Expand __Access management__ (Left panel) choose __Roles__, and then choose __Create policy__.
- Click on JSON
- Copy and paste the Policy from https://github.com/mevasaroj/AWS/blob/main/IAM_Roles/Policy_kms.tf
- Click __Next__
- Under **Review and create**
   - Policy Name : KMS-Key
   - Description : KMS-Key
   - Add Tags : Add require tags 
- Click __Create Policy__

# Add KMS Key Policy to Above **eks-workernode-role**
- Sign in to the AWS Management Console and open the IAM console at https://console.aws.amazon.com/iam/
- Below __Access management__ (Left Pane) --> Click **Roles**
- Select **eks-workernode-role** from list
- Under __Permission__ --> Click **Add Permission** --> Click **Attach Policies**
- Type __KMS__ in search --> Select (Check Mark) __KMS-Key__ Policy (Created above) --> Click **Add Permision**

# Update the Trust-Relationship of **eks-workernode-role**
- Sign in to the AWS Management Console and open the IAM console at https://console.aws.amazon.com/iam/
- Below __Access management__ (Left Pane) --> Click **Roles**
- Select **eks-workernode-role** from list
- Click **Trust relationships**
- Copy and paste the content from https://github.com/mevasaroj/AWS/blob/main/IAM_Roles/03_01_trust_relationship-workernode-role.tf
