module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name    = var.cluster_name
  vpc_id          = var.vpc_id
  subnet_ids      = var.private_subnets
  kubernetes_version = "1.36"

  
  enable_cluster_creator_admin_permissions = true
  endpoint_public_access  = false
  endpoint_private_access = true
  enable_irsa = true
  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.medium"]
      desired_size   = 2
      min_size       = 1
      max_size       = 3
    }
  }
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name = module.eks.cluster_name
  addon_name   = "vpc-cni"
}

resource "aws_eks_addon" "coredns" {
  cluster_name = module.eks.cluster_name
  addon_name   = "coredns"
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name = module.eks.cluster_name
  addon_name   = "kube-proxy"
}

resource "aws_security_group_rule" "bastion_to_eks" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"

  security_group_id        = module.eks.cluster_security_group_id
  source_security_group_id = var.bastion_sg_id

  description              = "Allow bastion to access EKS API"
}


resource "aws_security_group_rule" "node_to_node" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"

  security_group_id        = module.eks.node_security_group_id
  source_security_group_id = module.eks.node_security_group_id

  description              = "Allow all node-to-node communication"
}
