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
