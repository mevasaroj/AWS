# com.amazonaws.region.s3 - (Gateway Type) - creation

- Open the Amazon VPC console at https://console.aws.amazon.com/vpc/
- In the navigation pane, choose **Endpoints** under __PrivateLink and Lattice__
- Choose **Create endpoint**
- Choose the Following on page __Create endpoint__
   - Name  : **s3-gateway-endpoint**
   - For **Type**, choose **AWS services**
   - For **Services** : Type **s3** enter
      - Select __com.amazonaws.ap-south-1.s3__ Type __Gateway__
      
     
   - Under **Network setting**
       - VPC **Select the require vpc**
         
     - Under **Route tables**
        - Select the **route** associated with all **subnets**

     - Under **Policy**
       - Select **Full Access**


   - For **Services** : Type **s3** enter
     -   Under Tags : Add require tags
    
   - Click **Create endpoint**
