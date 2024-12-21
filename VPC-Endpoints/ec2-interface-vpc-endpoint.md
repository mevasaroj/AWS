# com.amazonaws.region.ec2 (Interface) - Creation
  - Open the Amazon VPC console at https://console.aws.amazon.com/vpc/
  - In the navigation pane, choose **Endpoints** under __PrivateLink and Lattice__
  - Choose **Create endpoint**
  - Choose the Following on page __Create endpoint__
     - Name  : **ec2-endpoint**
     - For **Type**, choose **AWS services**
       
     - Under **Services** :
       - Type **ec2** hit enter
       - Select **com.amazonaws.ap-south-1.ec2** from **Service Name**
       
     - Under **Network setting**
       - VPC **Select the require vpc**
         
       - under **Additional settings**
         - DNS Name : Check Mark **Enable DNS name**
         - DNS record IP type : Select **Ipv4**
           
     - Under **Subnets**
       - Select 1 subnet from each zone
  
     - Under **Security groups**
       - Select : **vpc-endpoint-sg** created above
      
     - Under **Policy**
       - Select **Full Access**
      
     -   Under Tags : Add require tags
     -   Click **Create endpoint**
  
