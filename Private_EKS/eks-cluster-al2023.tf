################################################################################
# Kubernetes provider configuration##############
################################################################################

provider "tls" {
  alias = "al2023-eks-cluster"
  proxy {
    from_env = true
  }
}

provider "kubernetes"{
  alias                  = "al2023-eks-cluster"
  host                   = module.al2023-eks-cluster.cluster_endpoint
  cluster_ca_certificate = base64decode(module.al2023-eks-cluster.cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    # This requires the awscli to be installed locally where Terraform is executed
    args = ["eks", "get-token", "--cluster-name", module.al2023-eks-cluster.cluster_name]
  }
}

################################################################################
# User Data configuration & Proxy Settings
################################################################################

locals {

  al2023-userdata = <<USERDATA
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==MYBOUNDARY=="

--==MYBOUNDARY==
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash
export eksclustercertificate=$(aws eks describe-cluster --query "cluster.certificateAuthority.data" --output text --name '${module.al2023-eks-cluster.cluster_name}' --region ap-south-1)
export apiserverendpoint=$(aws eks describe-cluster --query "cluster.endpoint" --output text --name '${module.al2023-eks-cluster.cluster_name}' --region ap-south-1)
export cidr=$(aws eks describe-cluster --query "cluster.kubernetesNetworkConfig.serviceIpv4Cidr" --output text --name '${module.al2023-eks-cluster.cluster_name}' --region ap-south-1)
cat > nodeadm.yaml<<EOF
apiVersion: node.eks.aws/v1alpha1
kind: NodeConfig
spec:
  cluster:
    apiServerEndpoint: $apiserverendpoint
    certificateAuthority: $eksclustercertificate
    cidr: $cidr
    name: '${module.al2023-eks-cluster.cluster_name}'
EOF
nodeadm init --config-source file://nodeadm.yaml



--==MYBOUNDARY==--

USERDATA

}


#################################################################################################################################################
# Custom Launch Template for Managed Node groups
#################################################################################################################################################

module "al2023-ondemand-lt" {
  source  = "terraform-aws-modules/autoscaling/aws"
  create = false   # AUTOSCALING GROUP
  
  name                   = join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env, "al2023-ondemand-lt"])
  key_name               = var.infra_key

   # aws ssm get-parameter --name /aws/service/eks/optimized-ami/1.31/amazon-linux-2023/x86_64/standard/recommended/image_id --region ap-south-1
   # aws ssm get-parameter --name /aws/service/eks/optimized-ami/1.30/amazon-linux-2023/arm64/standard/recommended/image_id --region ap-south-1
  image_id               = "ami-05b6aeac213e064e0" # - x86_64
  instance_type          = "m6a.xlarge" # For On-Demand - x86_64
  user_data              = base64encode(local.al2023-userdata)
  update_default_version = true
  security_groups        = ["${var.eks-cluster-workernode-sg}"]
  enable_monitoring      = false
  
  block_device_mappings = [
    {
      # Root volume
      device_name = "/dev/xvda"
      ebs = {
        encrypted    = true
        volume_size  = 20
        volume_type  = "gp3"
        delete_on_termination = true
        kms_key_id   = "<KMS-Key-ARN>"  # REPLACE WITH KMS-KEY 
      }
      }
  ]
  
  metadata_options       = {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit =  2
    instance_metadata_tags      = "enabled"
  }
   

  tag_specifications = [
    {
    resource_type = "instance"
    tags = merge(var.additional_tags, {
      Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "al2023-ondemand-eks-node"])
          } ) },
    {
    resource_type = "volume"
    tags = merge(var.additional_tags, {
      Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "al2023-ondemand-eks-node-volume"])
          } ) },
    {
    resource_type = "network-interface"
    tags = merge(var.additional_tags, {
      Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "al2023-ondemand-eks-node-eni"])
      } ) }
   ]
  
  tags = merge( { Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "al2023-ondemand-lt"]) }, 
    var.additional_tags ) 
}


##############################################################################################################################################################
# EKS Cluster & Managed Node groups Module 
##############################################################################################################################################################

module "al2023-eks-cluster" {

  providers = {
    tls        = tls.al2023-eks-cluster
  }


  #source  = "terraform-aws-modules/eks/aws"
  create = true

  cluster_name    = join("-", [local.org, local.csp, local.region, local.account, local.env, "al2023-eks-cluster"])
  cluster_version = "1.31"

  cluster_endpoint_public_access  = false
  cluster_endpoint_private_access = true
  create_cloudwatch_log_group     = false

  vpc_id                                = var.nonpcidss-prod-vpc
  control_plane_subnet_ids              = ["${var.cp-subnet-aza}", "${var.cp-subnet-azb}", "${var.cp-subnet-azc}"]
  create_cluster_security_group         = false
  cluster_security_group_id             = var.eks-cluster-additional-sg
  cluster_additional_security_group_ids = ["${var.eks-cluster-additional-sg}"]

  create_node_security_group = false
  node_security_group_id     = var.eks-cluster-workernode-sg

  enable_irsa     = true
  create_iam_role = false
  iam_role_arn    = "<EKS-Cluster-Role-ARN>"  # # REPLACE WITH EKS-Cluster-Role ARN 

  #===========================
  # EKS Cluster Encryption
  #===========================

  create_kms_key = false
  cluster_encryption_config = {
    resources : [
      "secrets"
    ],
    provider_key_arn = "<KMS-Key-ARN>"
  }

  #===========================
  # EKS Cluster Logging
  #===========================

  cluster_enabled_log_types = ["audit", "api", "authenticator", "controllerManager", "scheduler"]

  
  #===========================
  # EKS Managed Addons
  #===========================

  cluster_addons = {
    coredns = {
      most_recent                 = true
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "PRESERVE"
      tags = merge(var.additional_tags, {
        Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "app-coredns"])
        }
      )
    }
    kube-proxy = {
      most_recent                 = true
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
      tags = merge(var.additional_tags, {
        Name = join("-", [local.org, local.csp, local.region, local.vpcname, local.env, local.account, "app-kube-proxy"])
        }
      )
    }
    vpc-cni = {
      before_compute              = true
      most_recent                 = true
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
      configuration_values = jsonencode({
        env = {
           AWS_VPC_K8S_CNI_CUSTOM_NETWORK_CFG = "true"
           AWS_VPC_K8S_CNI_EXTERNALSNAT = "false"
           ENI_CONFIG_LABEL_DEF = "topology.kubernetes.io/zone"
           ENABLE_PREFIX_DELEGATION = "true"            
           WARM_PREFIX_TARGET = "1"
        }})
    	tags = merge(var.additional_tags, {
         Name = join("-", [local.org, local.csp, local.region, local.account, local.env, "aws-efs-csi-driver"])
         })
     }    
    aws-efs-csi-driver = {
       most_recent                 = true
       resolve_conflicts_on_create = "OVERWRITE"
       resolve_conflicts_on_update = "OVERWRITE"
       service_account_role_arn = "<eks-efs-role-arn>" # # REPLACE WITH EKS-EFS-Role ARN
       tags = merge(var.additional_tags, {
         Name = join("-", [local.org, local.csp, local.region, local.account, local.env, "aws-efs-csi-driver"])
         })
     }
     aws-ebs-csi-driver = {
       most_recent                 = true
       resolve_conflicts_on_create = "OVERWRITE"
       resolve_conflicts_on_update = "OVERWRITE"
       service_account_role_arn = "<eks-ebs-role-arn>" # # REPLACE WITH EKS-EBS-Role ARN
       tags = merge(var.additional_tags, {
         Name = join("-", [local.org, local.csp, local.region, local.account, local.env, "aws-ebs-csi-driver"])
         })
     }
    }

  #===========================
  # EKS Managed Nodegroups
  #===========================
  eks_managed_node_group_defaults = {
    cluster_version                 = null
    use_name_prefix                 = false
    use_custom_launch_template      = true
    create_launch_template          = false
    launch_template_use_name_prefix = false
    create_iam_role                 = false
    iam_role_arn                    = "<EKS-WorkerNode-Role-ARN>"  # # REPLACE WITH EKS-Cluster-WorkerNode-Role ARN
    force_update_version            = true
    update_config = {
      max_unavailable_percentage = "10"
    }
  }

  eks_managed_node_groups = {

  ondemand = {
      name               = join("-", [local.org, local.csp, local.region, local.vpcname, local.account, local.env, "ondemand-ng"])
      min_size           = 1      
      desired_size       = 1
      max_size           = 1
      launch_template_id = module.al2023-ondemand-lt.launch_template_id
      subnet_ids         = ["${var.dp-subnet-aza}", "${var.dp-subnet-azb}", "${var.dp-subnet-azc}"]   
      capacity_type      = "ON_DEMAND"  
      tags = merge(var.additional_tags, {
        Name = join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env, "ondemand-ng"])
      })
    }
  }
 
  # Cluster Tags
  tags = merge(var.additional_tags, {
    Name = join("-", [local.org, local.csp, local.region, local.account, local.vpcname, local.env, "al2023-eks-cluster"])
    } )
    
}

  
#=================================================================================================================================================================
