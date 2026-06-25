module "vpc" {
  source = "./modules/vpc"
}

module "bastion" {
  source = "./modules/bastion"

  vpc_id          = module.vpc.vpc_id
  public_subnet   = module.vpc.public_subnets[0]

  key_name        = "bastion-key"
  public_key_path = "~/.ssh/bastion-key.pub"

  ami = "ami-0f5ee92e2d63afc18"
}

module "eks" {
  source = "./modules/eks"

  cluster_name    = var.cluster_name
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets

  bastion_sg_id   = module.bastion.security_group_id
}


resource "aws_ecr_repository" "voting_app" {
  name                 = "voting-app"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "result_app" {
  name                 = "result-app"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
