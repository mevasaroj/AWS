# WorkerNode-role
- Sign in to the AWS Management Console and open the IAM console at https://console.aws.amazon.com/iam/
- In the navigation pane of the IAM console, Expand __Access management__ (Left panel) choose __Roles__, and then choose __Create role__.
- Under = Select Trusted entity type
   - Trusted entity type : AWS service
   - Use cases : type "ec2" --> Select "ec2" --> First Option
   - Under Add permission : Add Following Permission policies
      - AmazonEKSWorkerNodePolicy
      - AmazonEC2ContainerRegistryReadOnly
      - AmazonSSMManagedInstanceCore
      - AmazonEKS_CNI_Policy
      - AmazonEFSCSIDriverPolicy --> Optional for EFS if same role using for EFS for Pods as external Device
      - AmazonEBSCSIDriverPolicy --> Optional for EBS if same role using for EBS for Pods as external Device
      - AmazonEC2RoleforSSM --> Optional for SSM
  
 
- Under Name, review, and create
   - Role Name : **eks-workernode-role**
   - Description : __No Changes__
   - Step 1: Select trusted entities : __No Changes__
   - Step 2: Add permissions: __No Changes__
   - Step 3: Add Tags : Add the require tags
   -

- Click **create role**

