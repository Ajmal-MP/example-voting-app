terraform {
  backend "s3" {
    bucket         = "eks-terraform-state-vote-app-001"
    key            = "eks/terraform.tfstate"
    region         = "ap-south-1"
    use_lockfile = true
    encrypt        = true
  }
}
